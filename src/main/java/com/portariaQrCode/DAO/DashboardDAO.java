package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class DashboardDAO {
	private DAO dao;
	
	public DashboardDAO(DAO dao) {
		this.dao = dao;
	}
	
	public List<Registro> listarDash(Registro param) {
		return dao.listaRowAsRegistro("EXEC historico.listarLogAcessoDash @data=?, @tipoOperacao=?, @pessoa=?", 
				new Object[] {param.getAsStringNN("data"), param.getAsStringOrValue("tipoOperacao", ""),
								param.getAsIntOrValue("pessoa", -1)});
	}
}
