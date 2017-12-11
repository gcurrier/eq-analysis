package java.com.eq.controller.rest.api.impl;

import com.eq.controller.rest.GetResponseObject;
import com.eq.controller.rest.GetResponseObjectMetadata;
import com.eq.controller.rest.api.EqEventApi;
import com.eq.domain.eq.EqEvent;
import com.eq.service.RequestParameters;
import com.eq.service.eq.EqEventService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

@Component
public class EqEventApiImpl implements EqEventApi {

    @Resource(name = "eqEventService")
    private EqEventService eqEventService;
    /**
     * Used for logging actions.
     */
    private Logger log = LoggerFactory.getLogger(this.getClass());

    @Override
    public Response eventGet(List<String> fields, Integer offset, Integer limit, String sort, String filter, String q) throws NotFoundException {
        GetResponseObject responseObject = new GetResponseObject();

        RequestParameters params = RequestParameters.create(log,
                fields, offset, limit, sort, filter,
                null, null, null, null, null, q);
        responseObject.result(EqEvent.RESPONSE_KEY, eqEventService.fetchAll(params));
        responseObject.metadata(new GetResponseObjectMetadata().limit(limit).offset(offset).totalCount(eqEventService.countAll(params).intValue()));

        return Response.ok().entity(responseObject).build();
    }

    @Override
    public Response eventIdGet(String id, List<String> fields) throws NotFoundException {
//        BigDecimal newId = new BigDecimal(id);
        GetResponseObject retVal = new GetResponseObject();

        List<EqEvent> eqev = new ArrayList<>();
        eqev.add(eqEventService.fetchById(id));

        retVal.result(EqEvent.RESPONSE_KEY, eqev);
        retVal.metadata(new GetResponseObjectMetadata().limit(1).offset(0).totalCount(1));

        return Response.ok().entity(retVal).build();
    }
}

