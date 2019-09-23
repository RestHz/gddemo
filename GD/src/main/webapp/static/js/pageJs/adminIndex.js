
/**
 * 页面初始加载学生分页信息
 */
$(function () {
    getStudent(1);
});

/**
 * 老师分页信息
 */
function getTeacher(pn) {
    $("#loading").show();
    $.ajax({
        url:"/teacherList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $("#loading").hide();
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");
        }
    });
}

/**
 * 学生分页信息
 */
function getStudent(pn) {
    $("#loading").show();
    $.ajax({
        url:"/studentList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $("#loading").hide();
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");

        }
    });
}

/**
 * 课程分页信息
 */
function getCourse(pn) {
    $("#loading").show();
    $.ajax({
        url:"/courseList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $("#loading").hide();
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");
        }
    });
}

/**
 * 成绩分页信息
 */
function getScore(pn) {
    $("#loading").show();
    $.ajax({
        url:"/scoreList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $("#loading").hide();
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");
        }
    });
}

/**
 * 课表分页信息
 */
function getSchedule(pn) {
    $("#loading").show();
    $.ajax({
        url:"/scheduleList/"+pn,
        type:"GET",
        data:pn,
        dataType:"html",
        success:function (result) {
            $("#loading").hide();
            //先清空上次数据
            $("#DataMsg").empty();
            $(result).appendTo("#DataMsg");
        }
    });
}