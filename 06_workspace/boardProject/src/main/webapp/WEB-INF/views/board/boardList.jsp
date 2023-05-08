<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<%-- map에 저장된 값들을 각각 변수에 저장 --%>
<c:set var="pagination" value="${map.pagination}"/>
<c:set var="boardList" value="${map.boardList}"/>

<c:set var="boardName" value="${boardTypeList[boardCode-1].BOARD_NAME}"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${boardName}</title>

    <link rel="stylesheet" href="/resources/css/board/boardList-style.css">

</head>
<body>
    <main>
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>

        
        <section class="board-list">

            <h1 class="board-name">${boardName}</h1>


            <div class="list-wrapper">
                <table class="list-table">
                    
                    <thead>
                        <tr>
                            <th>글번호</th>
                            <th>제목</th>
                            <th>작성자</th>
                            <th>작성일</th>
                            <th>조회수</th>
                            <th>좋아요</th>
                        </tr>
                    </thead>

                    <tbody>
                                <!-- 게시글 목록 조회 결과가 비어있다면 -->
                        <c:choose>

                            <c:when test="${empty boardList}"> <%-- 조건(test="")은 항상 EL구문(${})으로 작성 --%>
                                        <%-- 조회된 게시글 목록이 비어있거나 null인 경우 --%>
                                <tr>
                                    <th colspan="6">게시글이 존재하지 않습니다.</th>
                                </tr>
                            </c:when>
                        
                                <%-- 게시글 목록 조회 결과가 있다면 --%>
                            <c:otherwise>
                                <c:forEach items="${boardList}" var="board">
                                    <tr>
                                        <td>${board.boardNo}</td>
                                        <td> 
                                            <%-- 썸네일이 있을 경우 --%>
                                            <c:if test="${not empty board.thumbnail}" >
                                                <img class="list-thumbnail" src="${board.thumbnail}">
                                            </c:if>

                                            <%-- ${boardCode} : @Pathvariable로 request scope에 추가된 값 --%>
                                            <a href="/board/${boardCode}/${board.boardNo}">${board.boardTitle}</a>   
                                            [${board.commentCount}]                        
                                        </td>
                                        <td>${board.memberNickname}</td>
                                        <td>${board.boardCreateDate}</td>
                                        <td>${board.readCount}</td>
                                        <td>${board.likeCount}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>


                    </tbody>
                </table>
            </div>


            <div class="btn-area">

            <!-- 로그인 상태일 경우 글쓰기 버튼 노출 -->
                <button id="insertBtn">글쓰기</button>                     

            </div>


            <div class="pagination-area">


                <ul class="pagination">
                
                    <!-- 첫 페이지로 이동 -->
                    <li><a href="/board/${boardCode}?cp=1">&lt;&lt;</a></li>

                    <!-- 이전 목록 마지막 번호로 이동 -->
                    <li><a href="/board/${boardCode}?cp=${pagination.prevPage}">&lt;</a></li>

               
                    <!-- 특정 페이지로 이동 -->
                    <c:forEach var="i" begin="${pagination.startPage}"
                                            end="${pagination.endPage}" step="1">
                    <c:choose>
                       <c:when test="${i == pagination.currentPage}">
                         <!-- 현재 보고있는 페이지 -->
                    <li><a class="current">${i}</a></li>
                       </c:when>
                    
                       <c:otherwise>
                     <!-- 현재 페이지를 제외한 나머지 -->
                    <li><a href="/board/${boardCode}?cp=${i}">${i}</a></li>

                       </c:otherwise>
                    </c:choose>

                    </c:forEach>
                  
                    
                    <!-- 다음 목록 시작 번호로 이동 -->
                    <li><a href="/board/${boardCode}?cp=${pagination.nextPage}">&gt;</a></li>

                    <!-- 끝 페이지로 이동 -->
                    <li><a href="/board/${boardCode}?cp=${pagination.maxPage}">&gt;&gt;</a></li>

                </ul>
            </div>


         <!-- 검색창 -->
            <form action="#" method="get" id="boardSearch">

                <select name="key" id="searchKey">
                    <option value="t">제목</option>
                    <option value="c">내용</option>
                    <option value="tc">제목+내용</option>
                    <option value="w">작성자</option>
                </select>

                <input type="text" name="query"  id="searchQuery" placeholder="검색어를 입력해주세요.">

                <button>검색</button>
            </form>

        </section>
    </main>
    
    
    <!-- 썸네일 클릭 시 모달창 출력 -->
    <div class="modal">
        <span id="modalClose">&times;</span>
        <img id="modalImage" src="/resources/images/user.png">
    </div>


    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>

</body>
</html>