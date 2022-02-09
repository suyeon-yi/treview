<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="panel panel-default">
	<div class="panel-heading">
		<h3>
			이미지
		</h3>
	</div>
	<div class="panel-body">
		<div class="row">
			<!-- col-md-3 : 한 줄에 사진 4장 표시 3 * 4 = 12 -->
			<c:forEach items="${imageList }" var="vo">
				<div class="col-md-4">
					<div class="thumbnail imageDataRow" data-no="${vo.no}">
						<img src="${vo.fileName}" alt="Photo Lists">
						<div class="caption">
							<p>[${vo.no }] ${vo.title }</p>
							${vo.name }(${vo.id }) - ${vo.writeDate }
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>