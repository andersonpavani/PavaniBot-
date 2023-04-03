//+------------------------------------------------------------------+
//|                                                         Robo.mqh |
//|                                           Anderson Campos Pavani |
//|                   https://www.andersonpavani.com.br/market/robos |
//+------------------------------------------------------------------+
#property copyright "Anderson Campos Pavani"
#property link      "https://www.andersonpavani.com.br/market/robos"


//Includes
#include "Enumeradores.mqh"


class CRobo {
private:
  bool IniciarAposLeilao;
  EnumTipoExecucao TipoExecucao;
  EnumHorarios HorarioInicial;
  EnumHorarios HorarioFinal;
  int QuantidadeOperacoesSimultaneas;
  double Lucro;
public:
  bool EmProcessamento;
  
  CRobo(const EnumHorarios _HorarioInicial, const EnumHorarios _HorarioFinal, const int _QuantidadeOperacoesSimultaneas, const bool _IniciarAposLeilao);
  ~CRobo();
  
  EnumRoboStatus GetStatus();
  EnumTipoExecucao GetTipoExecucao();
  int GetQuantidadeOperacoesSimultaneas();
  bool GetIniciarAposLeilao();
  void AdicionarLucro(const double Resultado);
};


//Variaveis Globais
CRobo *Robo;


CRobo::CRobo(const EnumHorarios _HorarioInicial, const EnumHorarios _HorarioFinal, const int _QuantidadeOperacoesSimultaneas, const bool _IniciarAposLeilao) {
  Lucro = 0;
  EmProcessamento = false;
  
  HorarioInicial = _HorarioInicial;
  HorarioFinal = _HorarioFinal;
  QuantidadeOperacoesSimultaneas = _QuantidadeOperacoesSimultaneas;
  IniciarAposLeilao = _IniciarAposLeilao;
  
  if (MQLInfoInteger(MQL_TESTER)) {
    TipoExecucao = Backteste;
  } else if (AccountInfoInteger(ACCOUNT_TRADE_MODE) == ACCOUNT_TRADE_MODE_REAL) {
    TipoExecucao = Real;
  } else {
    TipoExecucao = Demo;
  }
}

CRobo::~CRobo() {
}

EnumRoboStatus CRobo::GetStatus() {
  datetime DataHoraInicial = StringToTime(HorarioToString(HorarioInicial));
  
  if (TipoExecucao != Backteste && IniciarAposLeilao) {
    DataHoraInicial = StringToTime("10:00");
  }

  datetime DataHoraFinal = StringToTime(HorarioToString(HorarioFinal));
  
  return TimeCurrent() >= DataHoraInicial && TimeCurrent() < DataHoraFinal ? Ativo : ForaHorario;
}

EnumTipoExecucao CRobo::GetTipoExecucao() {
  return TipoExecucao;
}

int CRobo::GetQuantidadeOperacoesSimultaneas() {
  return QuantidadeOperacoesSimultaneas;
}

bool CRobo::GetIniciarAposLeilao() {
  return IniciarAposLeilao;
}

void CRobo::AdicionarLucro(const double Resultado) {
  Lucro += Resultado;
}