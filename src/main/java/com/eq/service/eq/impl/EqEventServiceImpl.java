package java.com.eq.service.eq.impl;

import com.eq.domain.eq.EqEvent;
import com.eq.service.eq.EqEventService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.List;

@Service(value = "eqEventService")
@Repository
@Transactional
public class EqEventServiceImpl implements EqEventService {
    /**
     * Used for logging actions.
     */
    private final Logger log = LoggerFactory.getLogger(this.getClass());

    /**
     * The entity manager for database transactions.
     */
    @PersistenceContext
    private EntityManager em;

    @Override
    public Long countAll(com.eq.service.RequestParameters params) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<Long> q = cb.createQuery(Long.class);
        Root<EqEvent> r = q.from(EqEvent.class);
        //set filter and apply
        Predicate qPredicate = computeFilterPredicate(params.getFilter(), cb, r, log);
        q = qPredicate == null ? q.select(cb.count(r)) : q.select(cb.count(r)).where(qPredicate);
        //create query and apply offset and limit
        return em.createQuery(q).getSingleResult();
    }

    @Override
    public List<EqEvent> fetchAll(com.eq.service.RequestParameters params) {
        CriteriaBuilder cb = em.getCriteriaBuilder();
        CriteriaQuery<EqEvent> q = cb.createQuery(EqEvent.class);
        Root<EqEvent> r = q.from(EqEvent.class);
        //fields to return are filtered in the rest controller when performing the type conversion via jackson mapper
        //set filter and apply
        Predicate qPredicate = computeFilterPredicate(params.getFilter(), cb, r, log);
        q = qPredicate == null ? q.select(r) : q.select(r).where(qPredicate);
        //set sort
        q.orderBy(computeOrdering(params.getSort(), cb, r));
        //create query and apply offset and limit
        TypedQuery<EqEvent> qry = em.createQuery(q);
        //set offset - defaults to 0
        qry.setFirstResult(params.getOffset());
        //set limit - defaults to -1
        if (params.getLimit() != -1)
            qry.setMaxResults(params.getLimit());
        return qry.getResultList();
    }

    @Override
    public EqEvent fetchByEntity(EqEvent entity) {
        //by id
        if (entity.getEqEvID() != null)
            return fetchById(entity.getEqEvID());
        throw new NoResultException("Could not resolve entity or no database entry present.");
    }

    @Override
    public EqEvent fetchById(String id) {
        return em.find(EqEvent.class, id);
    }
}
