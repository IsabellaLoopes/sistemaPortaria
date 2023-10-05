<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="PT-br">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<link rel="icon" href="${pageContext.request.contextPath}/img/icone_cadeado.png"/>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
	<title><tiles:getAsString name="title" /></title>
	<tiles:insertAttribute name="cssBlock"></tiles:insertAttribute>
	
	<script>
		const CONTEXT = "${pageContext.request.contextPath}";
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

	
	<jsp:include page="/WEB-INF/jsp/util/validacao.jsp" />
	<jsp:include page="/WEB-INF/jsp/util/util.jsp" />
</head>

<body>
	<!-- Header -->
	<tiles:insertAttribute name="header" />

	<section id="conteudo">
		<tiles:insertAttribute name="body" />

		<div class="mt-3 containerForm" id="table-responsive"></div>
		<div id="modal-responsive"></div>
	</section>

	<tiles:insertAttribute name="footer" />
	
	<script defer src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" integrity="sha384-rOA1PnstxnOBLzCLMcre8ybwbTmemjzdNlILg8O7z1lUkLXozs4DHonlDtnE7fpc" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>