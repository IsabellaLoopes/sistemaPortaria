<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.offcanvas .dropdown {
	text-decoration: none !important;
	color: white !important;
}

#offcanvasGrande{
	border-radius: 0% 20% 20% 0%;
}

#offcanvasPequeno{
	border-radius: 0% 25% 25% 0%;
}

.offcanvasImg {
	width: 65%;
	margin-bottom: 15%;
}

.offcanvas input {
	width: 90%;
	float: center;
	margin: 2% 5% 0;
	border-radius: 50px;
	height: 5%
}

.offcanvas .input-progress {
	border-bottom: 1px solid rgba(0, 0, 0, 0.25);
	width: 90%;
	margin: 2% 5% 0;
	transition: width 0.6s ease-in-out;
	border-color: white;
	float: right;
}

a.dropdown {
	float: right;
	margin: 10% 5% 0;
}

#offcanvasPequeno {
	color: white;
	font-size: 250%;
}

#offcanvasPequeno div {
	float: center;
}

.offcanvasPequenoimg {
	width: 85%;
	float: center;
	margin-bottom: 35%;
}

#offcanvasPequeno .offcanvas-body {
	padding: 0;
	margin: 0;
	width: auto
}

.iMenu {
	margin-top: 25% !important
}
</style>

<div class="w-25 offcanvas offcanvas-start bgColor-primary"
	tabindex="-1" id="offcanvasGrande">
	<div class="offcanvas-header">
		<!-- <h5 class="offcanvas-title" id="offcanvasExampleLabel"></h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>  -->
	</div>
	<div class="offcanvas-body">
		<div style="text-align: center">
			<img style="cursor: pointer" onclick="javaScript: abrirPagina('/home', true, {}, false)" class="offcanvasImg"
				src="${pageContext.request.contextPath}/img/logo-letra-branca-transparente.png" />
		</div>
		<input class="form-control" type="search" aria-label="Pesquisar">

		<c:forEach items="${dados.MENU}" var="m">
			<c:if test="${m.men_menu == 0 && m.men_id != 5}">
				<div class="dropdown mt-3">
					<a class="dropdown" type="button" data-bs-toggle="dropdown" href="<c:if test="${m.men_id != 4}">#</c:if>" <c:if test="${m.men_id == 4}">onclick="javaScript: abrirPagina('${m.men_url}')"</c:if>>
						${m.men_descricao} </a>
					<div class="input-progress"></div>
					<c:if test="${m.men_id != 4}">
					<ul class="dropdown-menu">
						<c:forEach items="${dados.MENU}" var="s">
							<c:if test="${s.men_menu == m.men_id}">
								<li><a class="dropdown-item" href="#"
								onclick="javaScript: abrirPagina('${s.men_url}')">${s.men_descricao}</a></li>
							</c:if>
						</c:forEach>
					</ul>
					</c:if>
				</div>
			</c:if>
		</c:forEach>

		<a class="dropdown" type="button" href="#"
			style="margin-top: 21%; margin-right: 5%" onclick="javaScript: sair()"><i class="fa fa-power-off"></i></a>
		
		<a class="dropdown" type="button" href="#"
		style="margin-top: 20%; margin-right: 5%" onclick="javaScript: perfil()">Perfil</a>
	</div>
</div>

<div class="offcanvas offcanvas-start bgColor-primary" data-bs-scroll="true"
	data-bs-backdrop="false" tabindex="-1" id="offcanvasPequeno"
	style="width: 12%; cursor:pointer">
	<div style="text-align: center">
		<div class="offcanvas-header">
		</div>
		<div class="w-auto offcanvas-body">
			<img class="offcanvasPequenoimg"
				src="${pageContext.request.contextPath}/img/logo-letra-branca-transparente.png" />

			<div class="row" style="margin: 0 !important;">
				<c:forEach items="${dados.MENU}" var="m">
					<c:if test="${m.men_menu == 0 && m.men_id != 5 && m.men_icone != ''}">
						<div class="col-12 mt-3 iMenu">
							<i class="${m.men_icone}"></i>
						</div>
					</c:if>
				</c:forEach>
				<div class="col-12" style="margin-top: 90%">
					<i class="fa fa-user"></i>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
		let myOffcanvas = document.getElementById('offcanvasGrande')
		let myOffcanvas2 = document.getElementById('offcanvasPequeno')

		let bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas)
		let bsOffcanvas2 = new bootstrap.Offcanvas(myOffcanvas2)

		myOffcanvas.addEventListener('hidden.bs.offcanvas', function() {
			bsOffcanvas2.show();
			$('.offcanvas-backdrop').removeClass("show");
			bsOffcanvas.hide();
		})

		myOffcanvas2.addEventListener('click', function() {
			$("#offcanvasPequeno").removeClass("show");
			bsOffcanvas2.hide();
			bsOffcanvas.show();
		})
	})
	
	function menuPequeno(){
		let myOffcanvas2 = document.getElementById('offcanvasPequeno')
		let bsOffcanvas2 = new bootstrap.Offcanvas(myOffcanvas2)
		bsOffcanvas2.show();
		
		
	}
	
	function menuGrande(){
		let myOffcanvas = document.getElementById('offcanvasGrande')
		let bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas)
		bsOffcanvas.show();
	}
	
	function perfil(){
		let param = {
				id: parseInt(sessionStorage.getItem("pessoaId")),
				usuario: parseInt(sessionStorage.getItem("loginId")),
				qrText: sessionStorage.getItem("qrText")
		}
		abrirPagina('/perfil/perfilCabecalho', true, param)
	}
	
</script>