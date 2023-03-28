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
  EnumTipoExecucao TipoExecucao;
  EnumHorarios HorarioInicial;
  EnumHorarios HorarioFinal;
  int QuantidadeOperacoesSimultaneas;
  double Lucro;
public:
  bool EmProcessamento;
  
  CRobo(const EnumHorarios _HorarioInicial, const EnumHorarios _HorarioFinal, const int _QuantidadeOperacoesSimultaneas);
  ~CRobo();
  
  EnumRoboStatus GetStatus();
  EnumTipoExecucao GetTipoExecucao();
  int GetQuantidadeOperacoesSimultaneas();
  void AdicionarLucro(const double Resultado);
};


//Variaveis Globais
CRobo *Robo;


CRobo::CRobo(const EnumHorarios _HorarioInicial, const EnumHorarios _HorarioFinal, const int _QuantidadeOperacoesSimultaneas) {
  Lucro = 0;
  EmProcessamento = false;
  
  HorarioInicial = _HorarioInicial;
  HorarioFinal = _HorarioFinal;
  QuantidadeOperacoesSimultaneas = _QuantidadeOperacoesSimultaneas;
  
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
  datetime DataHoraFinal = StringToTime(HorarioToString(HorarioFinal));
  
  return TimeCurrent() >= DataHoraInicial && TimeCurrent() < DataHoraFinal ? Ativo : ForaHorario;
}

EnumTipoExecucao CRobo::GetTipoExecucao() {
  return TipoExecucao;
}

int CRobo::GetQuantidadeOperacoesSimultaneas() {
  return QuantidadeOperacoesSimultaneas;
}

void CRobo::AdicionarLucro(const double Resultado) {
  Lucro += Resultado;
}