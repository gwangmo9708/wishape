<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	  .target{ display: inline-block;
       width: 200px;
       white-space: nowrap;
       overflow: hidden;
       text-overflow: ellipsis; }
</style>


					<div class="row my-4">
						<div class="col">
							<c:choose>
								<c:when test="${empty user}">
									<a href="../member/login.do" class="btn btn-primary btn-lg form-control">로그인</a>
								</c:when>
								<c:otherwise>
									<div class="card text-white" style="background-color: #4169E1;">
										<div class="shadow card-body">
											<div class="fw-bold target">${user.id } 님</div>
											<div>반갑습니다.</div>
										</div>
									</div>
									<div class="mt-2">
										<hr>
									</div>
									<div class="card shadow py-3" style="background-color: #696969">
										<div class="row">
											<div class="col text-center text-white fw-bold">
												친구 목록
											</div>
										</div>
										<div class="row px-1">
											<div class="col text-center text-white fw-bold">
												<hr>
											</div>
										</div>
										<div class="row">
											<div class="col text-center text-white">
												참치가조아
											</div>
										</div>
										<div class="row mt-1">
											<div class="col text-center text-white">
												빡빡코딩
											</div>
										</div>
										<div class="row mt-1">
											<div class="col text-center text-white">
												몰랑아몰랑
											</div>
										</div>
<!-- 										<div class="row mt-1">
											<div class="col text-center text-white">
												. . .
											</div>
										</div> -->
										<div class="row mt-3">
											<div class="col text-center text-white">
												더보기
											</div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
							<div>
								<hr>
							</div>
							<div class="card shadow py-3" style="background-color: #4169E1;">
								<div class="row">
									<div class="col text-center text-white fw-bold">
										최근 본 위시
									</div>
								</div>
								<div class="row px-1">
									<div class="col text-center text-white fw-bold">
										<hr>
									</div>
								</div>
								<div class="row">
									<div class="col text-center text-white">
										30kg 감량
									</div>
								</div>
								<div class="row">
									<div class="col text-center text-white mt-1">
										세계여행
									</div>
								</div>
								<div class="row">
									<div class="col text-center text-white mt-1">
										정처기 따기
									</div>
								</div>
<!-- 								<div class="row">
									<div class="col text-center text-white mt-1">
										. . .
									</div>
								</div> -->
								<div class="row mt-3">
									<div class="col text-center text-white mt-1">
										더보기
									</div>
								</div>
							</div>
							
						</div>
					</div>
			


