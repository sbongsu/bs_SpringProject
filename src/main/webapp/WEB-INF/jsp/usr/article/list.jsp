<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageName" value="게시판"/>
<%@ include file="../common/head.jspf" %>
<div class="overflow-x-auto mt-12">
  <table class="table w-full">
          <colgroup>
          <col width="50" />
          <col width="80" />
          <col width="80" />
          <col width="80" />
          <col />
        </colgroup>
    <thead>
      <tr>
        <th></th> 
        <th>작성날짜</th> 
        <th>수정날짜</th> 
        <th>작성자</th>
        <th>제목</th>
      </tr>
    </thead> 
    <tbody>
      <tr>
        <th>1</th> 
        <td>Cy Ganderton</td> 
        <td>Quality Control Specialist</td> 
        <td>Blue</td>
        <td>title</td>
      </tr>
      <tr>
        <th>2</th> 
        <td>Hart Hagerty</td> 
        <td>Desktop Support Technician</td> 
        <td>Purple</td>
        <td>title</td>
      </tr>
      <tr>
        <th>3</th> 
        <td>Brice Swyre</td> 
        <td>Tax Accountant</td> 
        <td>Red</td>
        <td>title</td>
      </tr>
      <tr>
        <th>4</th> 
        <td>Marjy Ferencz</td> 
        <td>Office Assistant I</td> 
        <td>Crimson</td>
        <td>title</td>
      </tr>
    </tbody>
  </table>
</div>
<%@ include file="../common/foot.jspf" %>