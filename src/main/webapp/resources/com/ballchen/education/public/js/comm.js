/**
 * Created by chenzhao on 2016/6/3.
 */
define(function(require,exports,module){
    var public  = {};
    var ALERT_STATE = {
        "success":"alert-success",
        "info":"alert-info",
        "warning":"alert-warning",
        "danger":"alert-danger"
    }
    /**
     *序列化表单参数
     * @param formObject 表单jquery对象
     * @returns {{}}
     * @constructor
     */
    public.serializeForm = function(formObject){
        var formData = formObject.serializeArray();
        var returnObject = {};
        for(var i=0;i<formData.length;i++){
            returnObject[formData[i].name] = formData[i].value;
        }
        return returnObject;
    }
    /**
     * 获得bootstrapalert弹出框
     * @param state 状态，success,info,warning,danger
     * @param title 信息标题
     * @param info 信息内容
     * @returns {string}
     */
    public.bootstrapAlert = function(state,title,info){
        var alertDiv = "<div class=\"alert "+ALERT_STATE[state]+" alert-dismissible\" role=\"alert\">"+
            "<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>"+
            "<strong>"+title+"</strong>"+info+
            "</div>";
        return alertDiv;
    }
    //增加身份证验证
    public.isIdCardNo = function(num) {
        var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
        var parityBit = new Array("1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2","x");
        var varArray = new Array();
        var intValue;
        var lngProduct = 0;
        var intCheckDigit;
        var intStrLen = num.length;
        var idNumber = num;
        // initialize
        if ((intStrLen != 15) && (intStrLen != 18)) {
            return false;
        }
        // check and set value
        for (i = 0; i < intStrLen; i++) {
            varArray[i] = idNumber.charAt(i);
            if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
                return false;
            } else if (i < 17) {
                varArray[i] = varArray[i] * factorArr[i];
            }
        }
        if (intStrLen == 18) {
            //check date
            var date8 = idNumber.substring(6, 14);
            if (isDate8(date8) == false) {
                return false;
            }
            // calculate the sum of the products
            for (i = 0; i < 17; i++) {
                lngProduct = lngProduct + varArray[i];
            }
            // calculate the check digit
            intCheckDigit = parityBit[lngProduct % 11];
            // check last digit
            if (varArray[17] != intCheckDigit) {
                return false;
            }
        }
        else {        //length is 15
            //check date
            var date6 = idNumber.substring(6, 12);
            if (isDate6(date6) == false) {
                return false;
            }
        }
        return true;
    }
    function isDate6(sDate) {
        if (!/^[0-9]{6}$/.test(sDate)) {
            return false;
        }
        var year, month, day;
        year = sDate.substring(0, 4);
        month = sDate.substring(4, 6);
        if (year < 1700 || year > 2500) return false
        if (month < 1 || month > 12) return false
        return true
    }

    function isDate8(sDate) {
        if (!/^[0-9]{8}$/.test(sDate)) {
            return false;
        }
        var year, month, day;
        year = sDate.substring(0, 4);
        month = sDate.substring(4, 6);
        day = sDate.substring(6, 8);
        var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        if (year < 1700 || year > 2500) return false
        if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1] = 29;
        if (month < 1 || month > 12) return false
        if (day < 1 || day > iaMonthDays[month - 1]) return false
        return true
    }
    module.exports = public;
});