package models;


import com.fasterxml.jackson.databind.ObjectMapper;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;
import play.data.validation.Constraints;
import play.db.jpa.JPA;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "way_user")
public class WayUser {

    @Constraints.Email
    @Column(unique = true)
    public String email;

    public String firstName;

    public String lastName;

    @Id
    @GeneratedValue
    public int id;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "saved_ways", joinColumns = @JoinColumn(name = "way_user_id"), inverseJoinColumns = @JoinColumn(name = "way_id"))
    public List<WayImpl> savedWays;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public List<WayImpl> getSavedWays() {
        return savedWays;
    }

    public void setSavedWays(List<WayImpl> savedWays) {
        this.savedWays = savedWays;
    }

    public static WayUser save(WayUser user) {
        JPA.em().persist(user);
        return user;
    }

    public static WayUser findById(int id) {
        return JPA.em().find(WayUser.class, id);
    }

    public static WayUser findByEmail(String email) {
        Session session = (Session) JPA.em().getDelegate();
        Criteria criteria = session.createCriteria(WayUser.class);
        List list = criteria.add(Restrictions.eq("email", email)).list();
        if (list.size() > 1) {
            throw new RuntimeException("More than one entity was mapped to the same email address");
        }
        return (list.size() == 1) ? (WayUser) list.get(0) : null;
    }

    public static WayUser createWayUser() {
        WayUser u = new WayUser();
        JPA.em().persist(u);
        return u;
    }

    @Override
    public String toString() {
        try {
            return new ObjectMapper().writeValueAsString(this);
        } catch (Exception e) {
            return super.toString();
        }
    }
}