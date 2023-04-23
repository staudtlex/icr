// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// alpha_k_cpp
List alpha_k_cpp(NumericMatrix data, int metric, bool bootstrap, bool bootnp, int nboot, int nnp, NumericVector cmrg_seed, int n_threads);
RcppExport SEXP _icr_alpha_k_cpp(SEXP dataSEXP, SEXP metricSEXP, SEXP bootstrapSEXP, SEXP bootnpSEXP, SEXP nbootSEXP, SEXP nnpSEXP, SEXP cmrg_seedSEXP, SEXP n_threadsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericMatrix >::type data(dataSEXP);
    Rcpp::traits::input_parameter< int >::type metric(metricSEXP);
    Rcpp::traits::input_parameter< bool >::type bootstrap(bootstrapSEXP);
    Rcpp::traits::input_parameter< bool >::type bootnp(bootnpSEXP);
    Rcpp::traits::input_parameter< int >::type nboot(nbootSEXP);
    Rcpp::traits::input_parameter< int >::type nnp(nnpSEXP);
    Rcpp::traits::input_parameter< NumericVector >::type cmrg_seed(cmrg_seedSEXP);
    Rcpp::traits::input_parameter< int >::type n_threads(n_threadsSEXP);
    rcpp_result_gen = Rcpp::wrap(alpha_k_cpp(data, metric, bootstrap, bootnp, nboot, nnp, cmrg_seed, n_threads));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_icr_alpha_k_cpp", (DL_FUNC) &_icr_alpha_k_cpp, 8},
    {NULL, NULL, 0}
};

RcppExport void R_init_icr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
