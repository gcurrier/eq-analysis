package java.com.eq.service;

import com.eq.domain.core.*;
import org.slf4j.Logger;

import javax.persistence.criteria.*;
import java.math.BigDecimal;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

/**
 * Service interface for dal actions on auditable entities.
 *
 * @author froa
 * @version 2014-03-18
 */
public interface GenericService<T> {
    /**
     * Counts all entities in the system.
     *
     * @param requestParameters The parameters for this query.
     * @return The number of entities for this query.
     */
    Long countAll(RequestParameters requestParameters);

    /**
     * Returns all entities currently in the system.
     *
     * @param requestParameters The pagination parameters if pagination is needed.
     * @return A list of entities in the system.
     */
    List<T> fetchAll(RequestParameters requestParameters);

    /**
     * Returns the entity from the database which can be identified by the given entity.
     *
     * @param entity The entity to search for.
     * @return The copy of the entity currently saved in the database.
     */
    T fetchByEntity(T entity);

    /**
     * Returns the entity identified by the given id.
     *
     * @param id The id of the entity to retrieve.
     * @return The entity identified by the stated id.
     */
    T fetchById(String id);

    /**
     * @param filters
     * @param cb
     * @param r
     * @param log
     * @return
     */
    default Predicate computeFilterPredicate(List<FilterModel> filters, CriteriaBuilder cb, Root<T> r, Logger log) {
        return computeFilterPredicate(filters, cb, r, null, log);
    }

    /**
     * @param filters
     * @param cb
     * @param r
     * @param filterObject
     * @param log
     * @return
     */
    default Predicate computeFilterPredicate(List<FilterModel> filters, CriteriaBuilder cb, Root<T> r, Path filterObject, Logger log) {
        Predicate qPredicate = null;
        if (filters != null)
            for (FilterModel filter : filters) {
                //get base data
                String fieldName = null;
                String type = null;
                String stringFilter = null;
                Long longFilter = null;
                Long longFilterTo = null;
                Instant dateFilter = null;
                Instant dateFilterTo = null;
                List<String> listFilter = null;
                if (filter instanceof TextFilterModel) {
                    fieldName = ((TextFilterModel) filter).getFieldName();
                    type = ((TextFilterModel) filter).getType().toString();
                    stringFilter = ((TextFilterModel) filter).getFilter();
                } else if (filter instanceof NumberFilterModel) {
                    fieldName = ((NumberFilterModel) filter).getFieldName();
                    type = ((NumberFilterModel) filter).getType().toString();
                    longFilter = ((NumberFilterModel) filter).getFilter();
                    longFilterTo = ((NumberFilterModel) filter).getFilterTo();
                } else if (filter instanceof DateFilterModel) {
                    fieldName = ((DateFilterModel) filter).getFieldName();
                    type = ((DateFilterModel) filter).getType().toString();
                    dateFilter = ((DateFilterModel) filter).getDate();
                    dateFilterTo = ((DateFilterModel) filter).getDateTo();
                } else if (filter instanceof SetFilterModel) {
                    fieldName = ((SetFilterModel) filter).getFieldName();
                    type = "list";
                    listFilter = ((SetFilterModel) filter).getSet();
                }
                if (fieldName == null || type == null) {
                    log.warn("Unable to apply filter", filter);
                    continue;
                }
                //replace data prefix
                fieldName = fieldName.replaceFirst("data\\.", "");

                //apply filters
                if (filter instanceof TextFilterModel) {
                    if (stringFilter == null) {
                        //error case
                        log.warn("Text filter cannot be applied.", filter);
                        continue;
                    } else
                        stringFilter = stringFilter.toLowerCase();
                    Predicate textFilter;
                    //set path
                    Path<String> fp = filterObject != null ? filterObject.get(fieldName) : r.get(fieldName);
                    //create conditions
                    switch (type) {
                        case "equals":
                            textFilter = cb.equal(cb.lower(fp.as(String.class)), stringFilter);
                            break;
                        case "notEqual":
                            textFilter = cb.notEqual(cb.lower(fp.as(String.class)), stringFilter);
                            break;
                        case "contains":
                            textFilter = cb.like(cb.lower(fp.as(String.class)), "%" + stringFilter + "%");
                            break;
                        case "notContains":
                            textFilter = cb.notLike(cb.lower(fp.as(String.class)), "%" + stringFilter + "%");
                            break;
                        case "startsWith":
                            textFilter = cb.like(cb.lower(fp.as(String.class)), stringFilter + "%");
                            break;
                        case "endsWith":
                            textFilter = cb.like(cb.lower(fp.as(String.class)), "%" + stringFilter);
                            break;
                        default:
                            //error case
                            log.warn("Text filter cannot be applied.", filter);
                            continue;
                    }
                    //add to query
                    if (qPredicate == null)
                        qPredicate = textFilter;
                    else
                        qPredicate = cb.and(qPredicate, textFilter);
                } else if (filter instanceof NumberFilterModel) {
                    if (longFilter == null) {
                        //error case
                        log.warn("Number filter cannot be applied.", filter);
                        continue;
                    }
                    Predicate numberFilter;
                    //set path
                    Path<Long> fp = filterObject != null ? filterObject.get(fieldName) : r.get(fieldName);
                    //create conditions
                    switch (type) {
                        case "equals":
                            numberFilter = cb.equal(fp, longFilter);
                            break;
                        case "notEquals":
                            numberFilter = cb.notEqual(fp, longFilter);
                            break;
                        case "lessThanOrEqual":
                            numberFilter = cb.lessThanOrEqualTo(fp, longFilter);
                            break;
                        case "greaterThan":
                            numberFilter = cb.greaterThan(fp, longFilter);
                            break;
                        case "greaterThanOrEqual":
                            numberFilter = cb.greaterThanOrEqualTo(fp, longFilter);
                            break;
                        case "inRange":
                            if (longFilterTo == null) {
                                log.warn("Number filter cannot be applied.", filter);
                                continue;
                            }
                            numberFilter = cb.and(cb.greaterThanOrEqualTo(fp, longFilter), cb.lessThanOrEqualTo(fp, longFilterTo));
                            break;
                        default:
                            //error case
                            log.warn("Number filter cannot be applied.", filter);
                            continue;
                    }
                    //add to query
                    if (qPredicate == null)
                        qPredicate = numberFilter;
                    else
                        qPredicate = cb.and(qPredicate, numberFilter);
                } else if (filter instanceof DateFilterModel) {
                    if (dateFilter == null) {
                        //error case
                        log.warn("Date filter cannot be applied.", filter);
                        continue;
                    }
                    Predicate dateTimeFilter;
                    //set path
                    Path<String> fp = filterObject != null ? filterObject.get(fieldName) : r.get(fieldName);
                    //create conditions
                    switch (type) {
                        case "equals":
                            dateTimeFilter = cb.equal(fp.as(Instant.class), dateFilter);
                            break;
                        case "notEquals":
                            dateTimeFilter = cb.notEqual(fp.as(Instant.class), dateFilter);
                            break;
                        case "lessThanOrEqual":
                            dateTimeFilter = cb.lessThanOrEqualTo(fp.as(Instant.class), dateFilter);
                            break;
                        case "greaterThan":
                            dateTimeFilter = cb.greaterThan(fp.as(Instant.class), dateFilter);
                            break;
                        case "greaterThanOrEqual":
                            dateTimeFilter = cb.greaterThanOrEqualTo(fp.as(Instant.class), dateFilter);
                            break;
                        case "inRange":
                            if (dateFilterTo == null) {
                                log.warn("Number filter cannot be applied.", filter);
                                continue;
                            }
                            dateTimeFilter = cb.and(
                                    cb.greaterThanOrEqualTo(fp.as(Instant.class), dateFilter),
                                    cb.lessThanOrEqualTo(fp.as(Instant.class), dateFilterTo)
                            );
                            break;
                        default:
                            //error case
                            log.warn("Date filter cannot be applied.", filter);
                            continue;
                    }
                    //add to query
                    if (qPredicate == null)
                        qPredicate = dateTimeFilter;
                    else
                        qPredicate = cb.and(qPredicate, dateTimeFilter);
                } else if (filter instanceof SetFilterModel) {
                    if (listFilter == null) {
                        //error case
                        log.warn("Set filter cannot be applied.", filter);
                        continue;
                    }
                    //set path
                    Path<String> fp = filterObject != null ? filterObject.get(fieldName) : r.get(fieldName);
                    Predicate setFilter = fp.in(listFilter);
                    if (qPredicate == null)
                        qPredicate = setFilter;
                    else
                        qPredicate = cb.and(qPredicate, setFilter);
                }
            }
        return qPredicate;
    }

    /**
     * @param sortModelList
     * @param cb
     * @param r
     * @return
     */
    default List<Order> computeOrdering(List<SortModel> sortModelList, CriteriaBuilder cb, Root<T> r) {
        return computeOrdering(sortModelList, cb, r, null);
    }

    /**
     * @param sortModelList
     * @param cb
     * @param r
     * @param filterObject
     * @return
     */
    default List<Order> computeOrdering(List<SortModel> sortModelList, CriteriaBuilder cb, Root<T> r, Path filterObject) {
        List<Order> orderList = new ArrayList<>();
        if (sortModelList != null)
            for (SortModel x : sortModelList) {
                String fieldName = x.getColId();
                //replace data prefix
                fieldName = fieldName.replaceFirst("data\\.", "");
                //set path
                Path<String> fp = filterObject != null ? filterObject.get(fieldName) : r.get(fieldName);
                orderList.add(
                        x.getSort() == SortModel.SortDirection.ASC ?
                                cb.asc(fp) :
                                cb.desc(fp)
                );
            }
        return orderList;
    }
}
