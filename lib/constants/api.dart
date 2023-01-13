class Api {
  static const String baseUrl =
      'http://tutoronhandapi-dev.us-east-1.elasticbeanstalk.com';
  static const registerChildURL = "/parent/ChildUser/Create/";
  static const String childImagesEndpoint = '/parent/ChildUserImage/GetAll/';
  static const String assignSectionEndpoint =
      '/parent/AssignSection/AssignSection?';
  static const String getChildrenEndpoint = '/parent/Children/GetAll/';

  static const String gradesEndpoint = '/parent/Section/GetAvaliableGrades/';
  static const String subjectsEndpoint =
      '/parent/Section/GetAvaliableSubjects?';
  static const String sectionsEndpoint =
      '/parent/Section/GetAvaliableSections?';
  static const String subSectionsEndpoint = '/parent/Section/Get?';

  static const String childGradesEndpoint =
      '/child/Section/GetAvaliableGrades/';
  static const String childSubjectsEndpoint =
      '/child/Section/GetAvaliableSubjects?';
  static const String childSectionsEndpoint =
      '/child/Section/GetAvaliableSections?';
  static const String childSubSectionsEndpoint = '/child/Section/Get?';

  static const String rewardsEndpoint = '/parent/Reward/GetAll/';
  static const String rewardEndpoint = '/parent/Reward/Get?';
  static const String rewardsImagesEndpoint = '/parent/RewardImage/GetAll/';
  static const String rewardCreateEndpoint = '/parent/Reward/Create/';
  static const String deleteRewardEndpoint = '/parent/Reward/Delete?rewardId=';
  static const String rewardUpdateEndpoint = '/parent/Reward/Update/';

  static const String parentChoresEndpoint = '/parent/Chore/GetAll/';
  static const String choreEndpoint = '/parent/Chore/Get?';
  static const String choresImagesEndpoint = '/parent/ChoreImage/GetAll/';
  static const String choreCreateEndpoint = '/parent/Chore/Create/';
  static const String deleteChoreEndpoint = '/parent/Chore/Delete?choreId=';
  static const String choreUpdateEndpoint = '/parent/Chore/Update/';
  static const String approveChoreEndpoint = '/parent/Chore/Approve?';

  static const String childChoresEndpoint = '/child/Chore/GetAll/';
  static const String childchoreEndpoint = '/child/Chore/Get?';
  static const String childchoreCompleteEndpoint =
      '/child/Chore/CompleteChore?';
  static const String childRewardsEndpoint = '/child/Reward/GetAll';
  static const String childPointsEndpoint =
      '/child/ChildStatistics/GetChildStats';
  static const String childRewardEndpoint = '/child/Reward/Get?';
  static const String childAssignedRewardEndpoint = '/child/Reward/GetAssigned';
  static const String childPurchasedRewardEndpoint =
      '/child/Reward/GetPurchased';
  static const String childBuyRewardEndpoint = '/child/Reward/Buy';
  static const String childSendResultsEndpoint =
      '/child/Section/CompleteSection';
  static const String childRewardBuyEndpoint = '/child/Chore/CompleteChore?';

  static const String getManageChildrenEndpoint =
      '/parent/Children/GetManageChildrenList/';
  static const String getChildByIdEndpoint = '/parent/Children/GetById?';
  static const String editChildEndpoint = '/parent/Children/Update/';
  static const String deleteChildEndpoint = '/parent/Children/DeleteChild?';

  static const String childNotificationsEndpoint =
      '/child/ChildNotification/GetAll/';
  static const String parentNotificationsEndpoint =
      '/parent/ParentNotification/GetAll/';
}
