package models;

import java.util.List;

import static models.Utils.Transportation;

public interface WayInterface {
    public int getId();

    public void setId(int id);

    public String getTitle();

    public void setTitle(String title);

    public String getSubTitle();

    public void setSubTitle(String subTitle);

    public List<String> getDescriptions();

    public void setDescriptions(List<String> descriptions);

    public List<String> getTasks();

    public void setTasks(List<String> tasks);

    public List<String> getTips();

    public void setTips(List<String> tips);

    public List<String> getItems();

    public void setItems(List<String> items);

    public List<Transportation> getTransportation();

    public void setTransportation(List<Transportation> transportation);

    public String getCoverImage();

    public void setCoverImage(String coverImage);
}
