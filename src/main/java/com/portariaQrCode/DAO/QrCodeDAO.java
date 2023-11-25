package com.portariaQrCode.DAO;

import java.util.List;

import com.portariaQrCode.types.Registro;

public class QrCodeDAO {
	private DAO dao;
	
	public QrCodeDAO(DAO dao) {
		this.dao = dao;
	}

	public Registro qrCode(Registro param) {
		return dao.getRowAsRegistro("EXEC sistema.validarQrCode @qrCode=?, @aparelho=?",
				new Object[] {param.getAsString("qrText"), param.getAsIntOrValue("aparelho", 0)});
	}
	
	public List<Registro> listarQrCodesExistente(){
		return dao.listaRowAsRegistro("EXEC cadastro.listarQrCodesExistente");
	}
}
