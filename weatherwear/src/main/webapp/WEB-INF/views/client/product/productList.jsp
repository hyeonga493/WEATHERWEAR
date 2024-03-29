<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>WeatherWear 사용자</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- Google Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=EB+Garamond:wght@400;500&amp;family=Inter:wght@400;500&amp;family=Playfair+Display:ital,wght@0,400;0,700;1,400;1,700&amp;display=swap" rel="stylesheet">
	<!-- Vendor CSS Files -->
	<link href="resources/client/ZenBlog/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="resources/client/ZenBlog/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
	<!-- Template Main CSS Files -->
	<link href="resources/client/ZenBlog/assets/css/main.css" rel="stylesheet">
	<link href="resources/client/ZenBlog/assets/css/variables.css" rel="stylesheet">
	<style>
		.mb-2 { width: 210px; height: 50px; overflow: hidden}
		.col-lg-3 { height: 440px; padding-left: 5%;}
		.productName { width: 100%; }
		.productList { display: flex; flex-direction: row; flex-wrap: wrap;}
		.productOne { height: 470px; display: flex; flex-direction: column; align-items: center;}
		.text-board { font-weight: bolder; }
	</style>
</head>
<body class="hold-transition sidebar-collapse layout-top-nav">
	<div class="wrapper">
		<%@ include file="../header.jsp" %>
		<main id="main">
			<section>
				<div class="container">
					<div class="row">
						<div class="col-md-10 aos-init aos-animate" data-aos="fade-up">
							<c:if test="${ param.searchType != null  && param.searchType != 'productName' && param.searchType != 'productRegDate'}">
								<h3 class="category-title">Category: ${ param.searchType }</h3>
							</c:if>
							<!-- ProductList -->
							<div class="productList row">
								<c:forEach var="item" items="${productList}" varStatus="status">
								<!-- 상품 시작 -->
								<div class="col-md-3 lg productOne row" onclick="location.href='productInfo.do?productId=${ item.productId }'">
									<img src="${ item.mainImage }" alt="${ item.productId }_mainImage" class="img-fluid" style="width:100%; height:auto;">
									<div class="productOneInfo row"><br>
										<div class="post-meta">
											<span class="date">
												<c:choose>
													<c:when test="${ item.productCate == 11}">OUTER</c:when>
													<c:when test="${ item.productCate == 12}">TOPS</c:when>
													<c:when test="${ item.productCate == 13}">PANTS</c:when>
													<c:when test="${ item.productCate == 14}">SKIRTS</c:when>
													<c:when test="${ item.productCate == 15}">DRESS</c:when>
												</c:choose>
											</span> 
											<span class="mx-1">•</span> 
											<span>VIEW: ${ item.productView }</span></div>
										<h4 class="productName">${ item.productName }</h4>
										<h4><fmt:formatNumber value="${item.productPrice}" pattern="###,###"/></h4>
									</div>
								</div>
								<!-- 상품 끝 -->
								</c:forEach>
							</div>
							<!-- End ProductList -->
							<!-- Paging -->
							<div class="text-start py-4">
								<div class="custom-pagination">
									<c:if test="${pagination.prev}">
										<a href="#" class="prev" onclick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}', '${search.searchType}', '${search.keyword}', '${search.orderby}')">Prevous</a>
									</c:if>
									<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="pageId">
										<a class="page-link <c:out value="${pagination.page == pageId ? 'active':''}"/>" href="#" onclick="fn_pagination('${pageId}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}', '${search.searchType}', '${search.keyword}', '${search.orderby}')">${pageId}</a>
									</c:forEach>	
									<c:if test="${pagination.next}">
										<a href="#" class="next" onclick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}', '${search.searchType}', '${search.keyword}', '${search.orderby}')">Next</a>
									</c:if>
								</div>
							</div>
						</div>
						<!-- Category -->
						<div class="col-md-2">
							<div class="aside-block">
								<h3 class="aside-title">Categories</h3>
								<ul class="aside-links list-unstyled">
									<c:choose>
										<c:when test="${pagination.searchType == 'outer'}"><c:set var="type" value="outer"/></c:when>
										<c:when test="${pagination.searchType == 'tops'}"><c:set var="type" value="tops"/></c:when>
										<c:when test="${pagination.searchType == 'pants'}"><c:set var="type" value="pants"/></c:when>
										<c:when test="${pagination.searchType == 'skirts'}"><c:set var="type" value="skirts"/></c:when>
										<c:when test="${pagination.searchType == 'dress'}"><c:set var="type" value="dress"/></c:when>
										<c:otherwise><c:set var="type" value="new"/></c:otherwise>
									</c:choose>
									<li <c:if test="${type == 'new'}">class="text-board"</c:if>><a href="productList.do"><i class="bi bi-chevron-right"></i> NEW</a></li>
									<li <c:if test="${type == 'outer'}">class="text-board"</c:if>><a href="productList.do?searchType=outer"><i class="bi bi-chevron-right"></i> OUTER</a></li>
									<li <c:if test="${type == 'tops'}">class="text-board"</c:if>><a href="productList.do?searchType=tops"><i class="bi bi-chevron-right"></i> TOPS</a></li>
									<li <c:if test="${type == 'pants'}">class="text-board"</c:if>><a href="productList.do?searchType=pants"><i class="bi bi-chevron-right"></i> PANTS</a></li>
									<li <c:if test="${type == 'skirts'}">class="text-board"</c:if>><a href="productList.do?searchType=skirts"><i class="bi bi-chevron-right"></i> SKIRTS</a></li>
									<li <c:if test="${type == 'dress'}">class="text-board"</c:if>><a href="productList.do?searchType=dress"><i class="bi bi-chevron-right"></i> DRESS</a></li>
								</ul>
							</div>
							<!-- End Categories -->
						</div>
					</div>
				</div>
			</section>
		</main>
		<%@ include file="../footer.jsp" %>
	</div>

	<script src="resources/client/ZenBlog/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script  src="resources/util/plugins/sweetalert/jquery-lates.min.js"></script>
	<script src="resources/util/plugins/sweetalert/sweetalert2.js"></script>
	
	<!-- Template Main JS File -->
	<script src="resources/client/ZenBlog/assets/js/main.js"></script>
	<!-- sweetAlert (alert/confirm/toast) -->
	<script src="resources/util/js/sweetalert.js"></script>
	
	<script src="resources/util/js/paging.js"></script>
</body>
</html>