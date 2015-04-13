package serializers;

import com.fasterxml.jackson.databind.ObjectMapper;
import models.WayImpl;
import models.WayInterface;
import models.WayUser;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import static models.Utils.Transportation;

public class UserWaySerializer {
    public static String serialize(WayUser user, List<WayImpl> ways) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        final Set<Integer> savedWays = new TreeSet<>();
        for (WayImpl way : user.getSavedWays()) {
            savedWays.add(way.getId());
        }

        List<WayInterface> extendedWays = new ArrayList<>();
        for (final WayImpl way : ways) {
            extendedWays.add(new WayInterface() {

                public boolean isSaved = savedWays.contains(way.getId());

                @Override
                public int getId() {
                    return way.getId();
                }

                @Override
                public void setId(int id) {
                    way.setId(id);
                }

                @Override
                public String getTitle() {
                    return way.getTitle();
                }

                @Override
                public void setTitle(String title) {
                    way.setTitle(title);
                }

                @Override
                public String getSubTitle() {
                    return way.getSubTitle();
                }

                @Override
                public void setSubTitle(String subTitle) {
                    way.setSubTitle(subTitle);
                }

                @Override
                public List<String> getDescriptions() {
                    return way.getDescriptions();
                }

                @Override
                public void setDescriptions(List<String> descriptions) {

                }

                @Override
                public List<String> getTasks() {
                    return way.getTasks();
                }

                @Override
                public void setTasks(List<String> tasks) {
                    way.setTasks(tasks);
                }

                @Override
                public List<String> getTips() {
                    return way.getTips();
                }

                @Override
                public void setTips(List<String> tips) {
                    way.setTips(tips);
                }

                @Override
                public List<String> getItems() {
                    return way.getItems();
                }

                @Override
                public void setItems(List<String> items) {
                    way.setItems(items);
                }

                @Override
                public List<Transportation> getTransportation() {
                    return way.getTransportation();
                }

                @Override
                public void setTransportation(List<Transportation> transportation) {
                    way.setTransportation(transportation);
                }

                @Override
                public String getCoverImage() {
                    return way.getCoverImage();
                }

                @Override
                public void setCoverImage(String coverImage) {
                    way.setCoverImage(coverImage);
                }
            });
        }

        return mapper.writeValueAsString(extendedWays);
    }
}
