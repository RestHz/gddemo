package util;

import org.springframework.web.multipart.MultipartFile;

/**
 * @ClassName: ExtensionNameUtils
 * @Description: TODO
 * @Author: Carlson
 * @Date 2019/4/5 15:19
 * @Version: 1.0
 **/
public class ExtensionNameUtils {


    /**
     * 文件类型
     */
    public enum formatName{
        Excel,
        Images,
        Others
    }

    /**
     * 扩展名
     */
    public static String fileSuffixName;


    /**
     * 图片合法格式
     */
    public static final String[] IMAGE_FILE_EXT = new String[]{"jpg","bmp","jpeg","png","gif"};

    /**
     * Excel合法格式
     */
    public static final String[] EXCEL_FILE_EXT = new String[]{"xls","xlsx"};

    /**
     * 判断Excel格式
     * @param fileExt
     * @return
     */
    public static boolean isExcelFileAllowed(String fileExt){
        for (String ext: ExtensionNameUtils.EXCEL_FILE_EXT) {
            if (ext.equals(fileExt)){
                return true;
            }
        }
        return false;
    }

    /**
     * 判断图片格式
     * @param fileExt
     * @return
     */
    public static boolean isImageFileAllowed(String fileExt){
        for (String ext: ExtensionNameUtils.IMAGE_FILE_EXT) {
            if (ext.equals(fileExt)){
                return true;
            }
        }
        return false;
    }

    /**
     * 判断文件格式
     * @param file
     * @return
     */
    public static formatName determineExtName(MultipartFile file){

        //判断文件是否有扩展名
        int dotPos = file.getOriginalFilename().lastIndexOf(".");
        if (dotPos < 0){
            return formatName.Others;
        }

        //获取后缀名
        fileSuffixName = file.getOriginalFilename().substring(dotPos+1).toLowerCase();

        //判断文件扩站名是否是图片格式
        if (ExtensionNameUtils.isImageFileAllowed(fileSuffixName)){
            return formatName.Images;
        }

        //判断文件扩站名是否是Excel格式
        if (ExtensionNameUtils.isExcelFileAllowed(fileSuffixName)){
            return formatName.Excel;
        }

        return formatName.Others;
    }

}
