package models;

import play.db.ebean.Model;

import javax.persistence.Entity;
import javax.persistence.Id;

import static play.data.validation.Constraints.Email;
import static play.data.validation.Constraints.Required;

@Entity
public class WayUser extends Model {

    @Required
    @Email
    public String email;

    @Required
    public String fullname;

    public boolean isAdmin;

    @Id
    private Long id;

    public WayUser(String email, String fullname, boolean isAdmin, Long id) {
        this.email = email;
        this.fullname = fullname;
        this.isAdmin = isAdmin;
        this.id = id;
    }

    public static Finder<Long, WayUser> find = new Finder<>(Long.class, WayUser.class);

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}