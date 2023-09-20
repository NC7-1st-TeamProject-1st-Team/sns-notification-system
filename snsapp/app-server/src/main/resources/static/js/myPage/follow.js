    var myPageNo;

    function follow (memberNo) {
        myPageNo = document.getElementById("myPageNo").value;
        var httpRequest;
        /* 통신에 사용 될 XMLHttpRequest 객체 정의 */
        httpRequest = new XMLHttpRequest();
        /* httpRequest의 readyState가 변화했을때 함수 실행 */
        httpRequest.onreadystatechange = () => {
            /* readyState가 Done이고 응답 값이 200일 때 실행 */
            if (httpRequest.readyState === XMLHttpRequest.DONE) {
                if (httpRequest.status === 200) {
                    var result = httpRequest.response;
                } else {
                    alert('Request Error!');
                }
            }
        };
        /* Get 방식으로 name 파라미터와 함께 요청 */
        httpRequest.open('GET', '/myPage/follow?myPageNo=' + myPageNo + '&followingNo=' + memberNo);
        /* Response Type을 Json으로 사전 정의 */
        httpRequest.responseType = "json";
        /* 정의된 서버에 요청을 전송 */
        httpRequest.send();
    }

    function unfollow (memberNo) {
        myPageNo = document.getElementById("myPageNo").value;
        var httpRequest;
        /* 통신에 사용 될 XMLHttpRequest 객체 정의 */
        httpRequest = new XMLHttpRequest();
        /* httpRequest의 readyState가 변화했을때 함수 실행 */
        httpRequest.onreadystatechange = () => {
            /* readyState가 Done이고 응답 값이 200일 때 실행 */
            if (httpRequest.readyState === XMLHttpRequest.DONE) {
                if (httpRequest.status === 200) {
                    var result = httpRequest.response;
                } else {
                    alert('Request Error!');
                }
            }
        };
        /* Get 방식으로 name 파라미터와 함께 요청 */
        httpRequest.open('GET', '/myPage/unfollow?myPageNo=' + myPageNo + '&followingNo=' + memberNo);
        /* Response Type을 Json으로 사전 정의 */
        httpRequest.responseType = "json";
        /* 정의된 서버에 요청을 전송 */
        httpRequest.send();
    }