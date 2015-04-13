package models;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Order;
import play.data.validation.Constraints;
import play.db.jpa.JPA;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

import static models.Utils.Transportation;

@Entity
@Table(name="way")
public class WayImpl implements WayInterface {

    @Id
    private int id;

    @Constraints.Required
    private String title = "";

    @Constraints.Required
    private String subTitle;

    @ElementCollection
    @CollectionTable(name = "description", joinColumns = @JoinColumn(name = "way_id"))
    @Column(length = 1024)
    private List<String> descriptions = new ArrayList<>();

    @ElementCollection
    @CollectionTable(name = "task", joinColumns = @JoinColumn(name = "way_id"))
    @Column(length = 1024)
    private List<String> tasks = new ArrayList<>();

    @ElementCollection
    @CollectionTable(name = "tip", joinColumns = @JoinColumn(name = "way_id"))
    @Column(length = 1024)
    private List<String> tips = new ArrayList<>();

    @ElementCollection
    @CollectionTable(name = "item", joinColumns = @JoinColumn(name = "way_id"))
    @Column(length = 1024)
    private List<String> items  = new ArrayList<>();

    @ElementCollection
    @CollectionTable(name = "transportation", joinColumns = @JoinColumn(name = "way_id"))
    @Enumerated(EnumType.STRING)
    private List<Transportation> transportation  = new ArrayList<>();

    @Constraints.Required
    private String coverImage;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubTitle() {
        return subTitle;
    }

    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }

    public List<String> getDescriptions() {
        return descriptions;
    }

    public void setDescriptions(List<String> descriptions) {
        this.descriptions = descriptions;
    }

    public List<String> getTasks() {
        return tasks;
    }

    public void setTasks(List<String> tasks) {
        this.tasks = tasks;
    }

    public List<String> getTips() {
        return tips;
    }

    public void setTips(List<String> tips) {
        this.tips = tips;
    }

    public List<String> getItems() {
        return items;
    }

    public void setItems(List<String> items) {
        this.items = items;
    }

    public List<Transportation> getTransportation() {
        return transportation;
    }

    public void setTransportation(List<Transportation> transportation) {
        this.transportation = transportation;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public static WayImpl getWayById(int id) {
        return JPA.em().find(WayImpl.class, id);
    }

    @SuppressWarnings("unchecked")
    public static List<WayImpl> getAllWays() {
        Session session = (Session) JPA.em().getDelegate();
        Criteria criteria = session
                .createCriteria(WayImpl.class)
                .addOrder(Order.asc("id"));
        List<WayImpl> list = criteria.list();
        if (list.size() == 0) {
            throw new RuntimeException("There are no ways in the database");
        }

        return list;
    }

    public static WayImpl saveWay(WayImpl way) {
        JPA.em().persist(way);
        return way;
    }
}
