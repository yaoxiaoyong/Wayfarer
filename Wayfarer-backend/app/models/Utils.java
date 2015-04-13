package models;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public class Utils {

    public static enum Transportation {
        PUBLIC_TRANSPORT("public transport"),
        ON_FOOT("on foot"),
        CAR("car");


        String name;
        Transportation(String name) {
            this.name = name;
        }

        @JsonCreator
        public static Transportation getTransportation(final String val) {
            String lowerCased = val.toLowerCase();
            for(Transportation t : values()){
                if( t.name.equals(lowerCased)){
                    return t;
                }
            }
            return null;
        }

        @JsonValue
        public String getJsonValue() {
            return this.name;
        }

    }
}
