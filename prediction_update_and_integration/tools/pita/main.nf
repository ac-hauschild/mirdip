/* 
 * Enable DSL 2 syntax
 */
nextflow.enable.dsl = 2

/* 
 * Import modules 
 */
include {
    BATCH_PREDICT_PITA
} from './modules.nf'

workflow run_pita {
  take: mirs_cross_utrs
  main:
    BATCH_PREDICT_PITA(mirs_cross_utrs)
}

// note that we should add the filter on record.seqString =~ /^Sequence unavailable/ and also for a minimum length here
workflow {
    run_pita(channel.fromPath(params.mirs).splitFasta( file: true, by: params.mirs_per_process ).combine(channel.fromPath(params.utrs).splitFasta( file: true, by: params.utrs_per_process ))) 
}