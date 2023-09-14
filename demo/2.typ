#import "../mpri.typ"
#import "../edt.typ"
#import "../typtyp.typ"
#let tt = typtyp

// Edit this: uncomment exactly the classes you take
#let chosen = tt.ret(tt.array(mpri.Class), (
  /* === Monday === */
  /*--  8h45 --*/
//mpri.proof_asst,
  mpri.automata_mod,
  /*-- 12h45 --*/
//mpri.symbolic_dyn,
  mpri.advanced_verif,
  /*-- 16h15 --*/
//mpri.proof_systems,
  mpri.algo_wqo,
//mpri.network_mod,
  mpri.biochem_prog,

  /* === Tuesday === */
  /*--  8h45 --*/
//mpri.sync_sys,
  mpri.sec_protocols,
  /*-- 12h45 --*/
//mpri.lang_mod,
  mpri.graph_mining,
//mpri.param_compl,
  mpri.quantum_crypto,
  /*-- 16h15 --*/
//mpri.linear_logic,
  mpri.poly_sys,

  /* === Wednesday === */
  /*--  8h45 --*/
//mpri.cryptanalysis,
//mpri.error_corr,
  mpri.da_networks,
  /*-- 12h45 --*/
//mpri.fp_and_types,
  mpri.combinatorics,
  /*-- 16h15 --*/
//mpri.analysis_algo,

  /* === Thursday === */
  /*-- 8h45 --*/
//mpri.abstract_interp,
  mpri.search_heuristics,
  mpri.geometric_graphs,
  /*-- 12h45 --*/
//mpri.topology,
  mpri.quantum_info,
//mpri.proba_prog,
  /*-- 16h15 --*/
//mpri.rand_compl,
  mpri.comp_algebra,
//mpri.graph_theory,

  /* === Friday === */
  /*--  8h45 --*/
//mpri.arith_crypto,
//mpri.concurrency,
  mpri.uncertainty,
  mpri.proof_of_prog,
  /*-- 12h45 --*/
//mpri.da_shared,
  mpri.game_theory,
  /*-- 16h15 --*/
//mpri.categories,
  mpri.algo_verif,
  mpri.data_analysis,
))

#show: doc => [
  #edt.conf(mpri.week, chosen)
]
