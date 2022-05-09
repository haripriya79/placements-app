

import 'package:placement_cell_app/models/jobs.dart';
import 'package:placement_cell_app/screens/view_all_jobs_screen.dart';

class ViewAllJobsArguments{
  final List<Jobs> jobs;
  ViewAllJobsArguments(this.jobs);
}

class JobDetails{
  final Jobs job;
  JobDetails(this.job);
}