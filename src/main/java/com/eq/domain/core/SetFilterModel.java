package java.com.eq.domain.core;

import java.util.ArrayList;
import java.util.List;

/**
 * SetFilterModel
 */
public class SetFilterModel extends ArrayList<String> implements FilterModel {
    private String fieldName = null;

    public SetFilterModel fieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public String getFieldName() {
        return fieldName;
    }

    public SetFilterModel setFieldName(String fieldName) {
        this.fieldName = fieldName;
        return this;
    }

    public List<String> getSet() {
        return this;
    }

    public SetFilterModel setSet(List<String> set) {
        this.addAll(set);
        return this;
    }


}

