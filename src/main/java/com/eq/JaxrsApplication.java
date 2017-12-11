package java.com.eq;

import org.springframework.stereotype.Component;

import javax.ws.rs.ApplicationPath;

@Component
@ApplicationPath("/eq")
public class JaxrsApplication extends javax.ws.rs.core.Application {
}