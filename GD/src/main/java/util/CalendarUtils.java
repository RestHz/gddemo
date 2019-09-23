package util;

import java.util.Calendar;

/**
 * @ClassName: CalendarUtils
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/27 22:35
 * @Version: 1.0
 **/
public class CalendarUtils {

    public static String weekDay(){
        Calendar calendar = Calendar.getInstance();
        int weekDay = calendar.get(Calendar.DAY_OF_WEEK);
        String week = "";
        if (Calendar.MONDAY == weekDay){
            week =  "星期一";
        }
        if (Calendar.TUESDAY == weekDay){
            week =  "星期二";
        }
        if (Calendar.WEDNESDAY == weekDay){
            week =  "星期三";
        }
        if (Calendar.THURSDAY == weekDay){
            week =  "星期四";
        }
        if (Calendar.FRIDAY == weekDay){
            week =  "星期五";
        }
        if (Calendar.SATURDAY == weekDay){
            week =  "星期六";
        }
        if (Calendar.SUNDAY == weekDay){
            week =  "星期日";
        }
        return week;
    }

}
