#import "typtyp.typ"
#let tt = typtyp
#import "time.typ"
#import "classes.typ"

// Re-exports for backwards compatibility
#let Class = classes.Class

#let verif = rgb("b8bb26").lighten(70%)
#let prog = rgb("fe8019").lighten(60%)
#let logic = rgb("fabd2f").lighten(60%)
#let algos = rgb("d3869b").lighten(50%)
#let data = rgb("fb4934").lighten(50%)

// List of classes
#let proof_asst = classes.new(verif)[Proof Assistants][2.7.2][Winterhalter]
#let automata_mod = classes.new(logic)[Automata Modelling][2.16][Picantin]
#let symbolic_dyn = classes.new(logic)[Symbolic Dynamics][2.20.2][Berthé]
#let advanced_verif = classes.new(verif)[Technics of Verification][2.8][Bouyer]
#let proof_systems = classes.new(verif)[Foundations of Proof Systems][2.7.1][Dowek]
#let algo_wqo = classes.new(verif)[Well Quasi-Order Theory][2.9.1][Finkel]
#let network_mod = classes.new(logic)[Network Models][2.17.1][Mairesse]
#let biochem_prog = classes.new(prog)[Biochemical Programming][2.19][Fages]
#let sync_sys = classes.new(prog)[Synchronous Systems][2.23][Pouzet]
#let sec_protocols = classes.new(verif)[Security Protocols][2.30][Blanchet]
#let lang_mod = classes.new(data)[Natural Language Modelling][2.27.1][Schmitz]
#let graph_mining = classes.new(data)[Graph Mining][2.29.2][Sozio]
#let param_compl = classes.new(algos)[Parameterized Complexity][2.11.1][Mitsou]
#let quantum_crypto = classes.new(algos)[Quantum Cryptography][2.34.2][Chailloux]
#let linear_logic = classes.new(logic)[Linear Logic][2.1][Kesner]
#let poly_sys = classes.new(algos)[Polynomial Systems][2.13.1][Faugère]
#let cryptanalysis = classes.new(algos)[Cryptanalysis][2.12.1][Minaud]
#let error_corr = classes.new(algos)[Error Correcting Codes][2.13.1][Faugère]
#let da_networks = classes.new(algos)[DA on Networks][2.18.1][Fraigniaud]
#let fp_and_types = classes.new(prog)[FP and Type Systems][2.4][Pottier]
#let combinatorics = classes.new(algos)[Combinatorics][2.10][Schaeffer]
#let analysis_algo = classes.new(algos)[Analysis of Algorithms][2.15][Ravelomanana]
#let abstract_interp = classes.new(verif)[Abstract Interpretation][2.6][Miné]
#let search_heuristics = classes.new(data)[Search Heuristics][2.24.2][Doerr]
#let geometric_graphs = classes.new(algos)[Geometric Graphs][2.38.1][Laplante]
#let topology = classes.new(data)[Topology][2.14.1][Glisse]
#let quantum_info = classes.new(algos)[Quantum Information][2.34.1][Laplante]
#let proba_prog = classes.new(logic)[Probabilistic PL][2.40][Tasson]
#let rand_compl = classes.new(algos)[Randomness in Complexity][2.11.2][Magniez]
#let comp_algebra = classes.new(algos)[Computer Algebra][2.22][Chyzak]
#let graph_theory = classes.new(data)[Graph Theory][2.29.1][Naserasr]
#let arith_crypto = classes.new(algos)[Arithmetic for Cryptology][2.12.2][Smith]
#let concurrency = classes.new(logic)[Concurrency][2.3.1][Haucourt]
#let uncertainty = classes.new(data)[Alg. and Uncertainty][2.24.1][Angelopoulos]
#let proof_of_prog = classes.new(verif)[Proof of Programs][2.36.1][Marché]
#let da_shared = classes.new(algos)[DA on Shared Memory][2.18.2][Delporte]
#let game_theory = classes.new(logic)[Game Theory][2.20.1][Zielonka]
#let categories = classes.new(logic)[Domains, Categories, Games][2.2][Melliès]
#let algo_verif = classes.new(verif)[Algorithmic Verification][2.9.2][Bouajjani]
#let data_analysis = classes.new(algos)[Data Analysis][2.39][Tierny]

#let starting-times = ((8,45), (10,15), (12,45), (14,15), (16,15), (17,45)).map(t => time.from-hm(..t))

#let full(period, descr, room, sem: (1,2)) = classes.slot(
  descr, room, sem: sem,
  start: starting-times.at((period - 1) * 2),
  len: time.from-hm(3, 0),
  ects: 3 * sem.len(),
)
#let short(period, slot, descr, room, sem: (1,2)) = classes.slot(
  descr, room, sem: sem,
  start: starting-times.at((period - 1) * 2 + slot - 1),
  len: time.from-hm(1, 30),
  ects: 3,
)

// Static timetable
#let week = tt.ret(classes.Week, (
  mon: (
    full(1, sem:(1,), proof_asst)[1002],
    full(1, automata_mod)[1004],
    short(2, 1, symbolic_dyn)[1002],
    full(2, advanced_verif)[1004],
    full(3, sem:(1,), proof_systems)[1004],
    full(3, sem:(1,), algo_wqo)[1002],
    full(3, sem:(2,), network_mod)[1002],
    full(3, sem:(2,), biochem_prog)[1004],
  ),
  tue: (
    full(1, sem:(1,), sync_sys)[1004],
    full(1, sec_protocols)[1002],
    full(2, sem:(1,), lang_mod)[1004],
    full(2, sem:(1,), graph_mining)[1002],
    full(2, sem:(2,), param_compl)[1002],
    full(2, sem:(2,), quantum_crypto)[1004],
    full(3, linear_logic)[1002],
    full(3, sem:(1,), poly_sys)[1004],
  ),
  wed: (
    short(1, 1, cryptanalysis)[1004],
    short(1, 2, error_corr)[1004],
    short(1, 2, da_networks)[1002],
    full(2, fp_and_types)[1002],
    full(2, combinatorics)[1004],
    full(2, analysis_algo)[1002],
  ),
  thu: (
    full(1, abstract_interp)[1004],
    full(1, sem:(2,), search_heuristics)[1002],
    full(1, sem:(1,), geometric_graphs)[1002],
    full(2, sem:(1,), topology)[1002],
    full(2, sem:(1,), quantum_info)[1004],
    full(2, sem:(2,), proba_prog)[1002],
    full(3, sem:(1,), rand_compl)[1002],
    full(3, comp_algebra)[1004],
    full(3, sem:(2,), graph_theory)[1002],
  ),
  fri: (
    full(1, sem:(1,), arith_crypto)[1004],
    full(1, sem:(2,), concurrency)[1002],
    full(1, sem:(1,), uncertainty)[1002],
    full(1, sem:(2,), proof_of_prog)[1004],
    full(2, sem:(1,), da_shared)[1002],
    full(2, sem:(1,), game_theory)[1004],
    full(3, categories)[1004],
    full(3, sem:(2,), algo_verif)[1002],
    full(3, sem:(1,), data_analysis)[1002],
  ),
))

