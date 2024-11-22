package ph.com.pbcom.job;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import static org.springframework.batch.core.observability.BatchMetrics.calculateDuration;
import static org.springframework.batch.core.observability.BatchMetrics.formatDuration;

@Component
public class CustomerJobListener implements JobExecutionListener {

    private Logger logger = LoggerFactory.getLogger(getClass());


    @Override
    public void beforeJob(JobExecution jobExecution) {
        logger.info("Start Date and Time: {}", logDateTimeFormatter(jobExecution.getStartTime()));
        logger.info("Job Number: {}", jobExecution.getJobId());
    }

    @Override
    public void afterJob(JobExecution jobExecution) {
        logger.info("=============================================");
        logger.info("Job Status: {}", jobExecution.getExitStatus().getExitCode());
        logger.info("Total time: {} ", formatDuration(calculateDuration(jobExecution.getStartTime(),
                jobExecution.getEndTime())));
        logger.info("Finished at: {}", logDateTimeFormatter(jobExecution.getEndTime()));
    }

    private String logDateTimeFormatter(LocalDateTime dateToConvert) {
        return dateToConvert.format(DateTimeFormatter.ofPattern("MM/dd/yyyy hh:mm:ss a"));
    }
}
