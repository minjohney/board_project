<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style type="text/css">
li {
	list-style: none;
	display: inline;
	padding: 6px;
}
</style>

<ul class="navbar-nav ml-auto">
<c:if test="${member == null}">
	<li class="nav-item">
			<a class="nav-link" href="/" style="font-size: 15px">LOGIN</a>
	</li>
	<li class="nav-item">
			<a class="nav-link" href="/member/register" style="font-size: 15px">SIGN</a>
		</li>
		</c:if>
		<c:if test="${member != null}">
		<li class="nav-item">
            <a style="font-size: 15px">${member.userId}님</a>
          </li>
	<li class="nav-item">
			<a class="nav-link" href="/member/logout" style="font-size: 15px">LOGOUT</a>
		</li>
	<li class="nav-item">
			<a class="nav-link" href="/member/memberUpdateView" style="font-size: 15px">MY</a>
		</li>
		</c:if>
</ul>