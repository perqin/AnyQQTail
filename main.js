.pragma library

var cont, tail;
var _signalCenter;

function requestSid(qq, pw, onSucceeded) {
    var url = "http://pt.3g.qq.com/qzoneLogin";
    var data = "sid=Ac-LbMpPhLBmlgYyoHvpXsId&qq=" + qq + "&pwd=" + pw + "&sidtype=1&hiddenPwd=true&aid=nLoginqz&vdata=15E30922620B15BB9697B968C0E0D08D";
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        switch (xhr.readyState) {
        case xhr.OPENED: break;
        case xhr.HEADERS_RECEIVED:
            if (xhr.status != 200)
                console.log("XMLHttpRequest : HEADERS_RECEIVED\nConnection Error with code " + xhr.status + " : " + xhr.statusText);
            break;
        case xhr.DONE:
            if (xhr.status == 200 || xhr.status == 302) {
                try {
                    console.log(xhr.responseText);
                    onSucceeded(getSid(xhr.responseText));
                } catch (err) {
                    console.log("Loading error.");
                    _signalCenter.postFailed();
                }
            } else {
                console.log("XMLHttpRequest : DONE\nConnection Error with code " + xhr.status + " : " + xhr.statusText);
                _signalCenter.postFailed();
            }
            break;
        }
    }
    console.log(url + "?" + data);
    xhr.open("POST", url);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Content-Length", data.length);
    xhr.send(data);
}

function postContent(sid) {
    var url = "http://m.qzone.com/mood/publish_mood";
    var data = "opr_type=publish_shuoshuo&content=" + cont + "&is_winphone=2&source_name=" + tail + "&sid=" + sid + "&richva=&lat=&lon=&lbsid=&issyncweibo=0&address=&format=json";
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        switch (xhr.readyState) {
        case xhr.OPENED: break;
        case xhr.HEADERS_RECEIVED:
            if (xhr.status != 200)
                console.log("XMLHttpRequest : HEADERS_RECEIVED\nConnection Error with code " + xhr.status + " : " + xhr.statusText);
            break;
        case xhr.DONE:
            if (xhr.status == 200) {
                try {
                    console.log(xhr.responseText);
                    var obj = JSON.parse(xhr.responseText);
                    if (obj.code == 0)
                        _signalCenter.postSucceeded();
                    else
                        _signalCenter.postFailed();
                } catch (err) {
                    console.log(qsTr("Loading error."));
                    _signalCenter.postFailed();
                }
            } else {
                console.log("XMLHttpRequest : DONE\nConnection Error with code " + xhr.status + " : " + xhr.statusText);
                _signalCenter.postFailed();
            }
            break;
        }

    }
    console.log(url + "?" + data);
    xhr.open("POST", url);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.setRequestHeader("Content-Length", data.length);
    xhr.send(data);
}

function getSid(rt) {
    var str = "" + rt;
    var i = str.search("sid=");
    i += 4;
    console.log("SID = " + str.substring(i, i + 24));
    return str.substring(i, i + 24);
}

function postShuoshuo(qq, pw) {
    requestSid(qq, pw, postContent);
}
