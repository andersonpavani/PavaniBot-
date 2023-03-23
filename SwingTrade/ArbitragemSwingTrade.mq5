//+------------------------------------------------------------------+
//|                                         ArbitragemSwingTrade.mq5 |
//|                                           Anderson Campos Pavani |
//|                   https://www.andersonpavani.com.br/market/robos |
//+------------------------------------------------------------------+

#property copyright "Anderson Campos Pavani"
#property link "https://www.andersonpavani.com.br/market/robos"
#property version "1.00"


int OnInit() {
  EventSetTimer(1);
  return(INIT_SUCCEEDED);
}


void OnDeinit(const int reason) {
  EventKillTimer();
}


void OnTimer() {
  
}


void OnTrade() {
  
}

