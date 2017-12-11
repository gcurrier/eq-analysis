package java.com.eq.controller.rest.api;

import org.springframework.stereotype.Component;

import javax.ws.rs.*;
import javax.ws.rs.core.Response;
import java.util.List;

@Component
@Path("/api")
public interface MoonRelApi {
    @GET
    @Path("/mrel")
    @Produces({"application/json"})
    Response eventGet(@QueryParam("fields") List<String> fields
            , @QueryParam("offset") Integer offset
            , @QueryParam("limit") Integer limit
            , @QueryParam("sort") String sort
            , @QueryParam("filter") String filter
            , @QueryParam("q") String q)
            throws NotFoundException;

    @GET
    @Path("/mrel/{id}")
    @Produces({"application/json"})
    Response eventIdGet(@PathParam("id") String id
            , @QueryParam("fields") List<String> fields)
            throws NotFoundException;
}
