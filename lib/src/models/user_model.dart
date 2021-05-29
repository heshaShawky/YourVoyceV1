class User {
  int userId;
  String email;
  String username;
  String displayname;
  int photoId;
  String status;
  String statusDate;
  String locale;
  String language;
  String timezone;
  int search;
  int showProfileviewers;
  int levelId;
  int invitesUsed;
  int extraInvites;
  int enabled;
  int verified;
  int approved;
  String creationDate;
  String modifiedDate;
  String lastloginDate;
  Null updateDate;
  int memberCount;
  int viewCount;
  int commentCount;
  int likeCount;
  int coverphoto;
  Null coverphotoparams;
  String viewPrivacy;
  int disableEmail;
  int disableAdminemail;
  Null lastPasswordReset;
  Null lastLoginAttempt;
  int loginAttemptCount;
  String lastLoginDate;
  String lastUpdateDate;
  String inviteeName;
  String profileType;
  String memberLevel;
  String profileViews;
  String joinedDate;
  String friendsCount;
  int seaoLocationid;
  String location;
  int followCount;
  int userCover;
  int donotsellinfo;
  String mention;
  String image;
  String imageNormal;
  String imageProfile;
  String imageIcon;
  String contentUrl;
  String cover;
  int showVerifyIcon;

  User(
      {this.userId,
      this.email,
      this.username,
      this.displayname,
      this.photoId,
      this.status,
      this.statusDate,
      this.locale,
      this.language,
      this.timezone,
      this.search,
      this.showProfileviewers,
      this.levelId,
      this.invitesUsed,
      this.extraInvites,
      this.enabled,
      this.verified,
      this.approved,
      this.creationDate,
      this.modifiedDate,
      this.lastloginDate,
      this.updateDate,
      this.memberCount,
      this.viewCount,
      this.commentCount,
      this.likeCount,
      this.coverphoto,
      this.coverphotoparams,
      this.viewPrivacy,
      this.disableEmail,
      this.disableAdminemail,
      this.lastPasswordReset,
      this.lastLoginAttempt,
      this.loginAttemptCount,
      this.lastLoginDate,
      this.lastUpdateDate,
      this.inviteeName,
      this.profileType,
      this.memberLevel,
      this.profileViews,
      this.joinedDate,
      this.friendsCount,
      this.seaoLocationid,
      this.location,
      this.followCount,
      this.userCover,
      this.donotsellinfo,
      this.mention,
      this.image,
      this.imageNormal,
      this.imageProfile,
      this.imageIcon,
      this.contentUrl,
      this.cover,
      this.showVerifyIcon});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    username = json['username'];
    displayname = json['displayname'];
    photoId = json['photo_id'];
    status = json['status'];
    statusDate = json['status_date'];
    locale = json['locale'];
    language = json['language'];
    timezone = json['timezone'];
    search = json['search'];
    showProfileviewers = json['show_profileviewers'];
    levelId = json['level_id'];
    invitesUsed = json['invites_used'];
    extraInvites = json['extra_invites'];
    enabled = json['enabled'];
    verified = json['verified'];
    approved = json['approved'];
    creationDate = json['creation_date'];
    modifiedDate = json['modified_date'];
    lastloginDate = json['lastlogin_date'];
    updateDate = json['update_date'];
    memberCount = json['member_count'];
    viewCount = json['view_count'];
    commentCount = json['comment_count'];
    likeCount = json['like_count'];
    coverphoto = json['coverphoto'];
    coverphotoparams = json['coverphotoparams'];
    viewPrivacy = json['view_privacy'];
    disableEmail = json['disable_email'];
    disableAdminemail = json['disable_adminemail'];
    lastPasswordReset = json['last_password_reset'];
    lastLoginAttempt = json['last_login_attempt'];
    loginAttemptCount = json['login_attempt_count'];
    lastLoginDate = json['lastLoginDate'];
    lastUpdateDate = json['lastUpdateDate'];
    inviteeName = json['inviteeName'];
    profileType = json['profileType'];
    memberLevel = json['memberLevel'];
    profileViews = json['profileViews'];
    joinedDate = json['joinedDate'];
    friendsCount = json['friendsCount'];
    seaoLocationid = json['seao_locationid'];
    location = json['location'];
    followCount = json['follow_count'];
    userCover = json['user_cover'];
    donotsellinfo = json['donotsellinfo'];
    mention = json['mention'];
    image = json['image'];
    imageNormal = json['image_normal'];
    imageProfile = json['image_profile'];
    imageIcon = json['image_icon'];
    contentUrl = json['content_url'];
    cover = json['cover'];
    showVerifyIcon = json['showVerifyIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['displayname'] = this.displayname;
    data['photo_id'] = this.photoId;
    data['status'] = this.status;
    data['status_date'] = this.statusDate;
    data['locale'] = this.locale;
    data['language'] = this.language;
    data['timezone'] = this.timezone;
    data['search'] = this.search;
    data['show_profileviewers'] = this.showProfileviewers;
    data['level_id'] = this.levelId;
    data['invites_used'] = this.invitesUsed;
    data['extra_invites'] = this.extraInvites;
    data['enabled'] = this.enabled;
    data['verified'] = this.verified;
    data['approved'] = this.approved;
    data['creation_date'] = this.creationDate;
    data['modified_date'] = this.modifiedDate;
    data['lastlogin_date'] = this.lastloginDate;
    data['update_date'] = this.updateDate;
    data['member_count'] = this.memberCount;
    data['view_count'] = this.viewCount;
    data['comment_count'] = this.commentCount;
    data['like_count'] = this.likeCount;
    data['coverphoto'] = this.coverphoto;
    data['coverphotoparams'] = this.coverphotoparams;
    data['view_privacy'] = this.viewPrivacy;
    data['disable_email'] = this.disableEmail;
    data['disable_adminemail'] = this.disableAdminemail;
    data['last_password_reset'] = this.lastPasswordReset;
    data['last_login_attempt'] = this.lastLoginAttempt;
    data['login_attempt_count'] = this.loginAttemptCount;
    data['lastLoginDate'] = this.lastLoginDate;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['inviteeName'] = this.inviteeName;
    data['profileType'] = this.profileType;
    data['memberLevel'] = this.memberLevel;
    data['profileViews'] = this.profileViews;
    data['joinedDate'] = this.joinedDate;
    data['friendsCount'] = this.friendsCount;
    data['seao_locationid'] = this.seaoLocationid;
    data['location'] = this.location;
    data['follow_count'] = this.followCount;
    data['user_cover'] = this.userCover;
    data['donotsellinfo'] = this.donotsellinfo;
    data['mention'] = this.mention;
    data['image'] = this.image;
    data['image_normal'] = this.imageNormal;
    data['image_profile'] = this.imageProfile;
    data['image_icon'] = this.imageIcon;
    data['content_url'] = this.contentUrl;
    data['cover'] = this.cover;
    data['showVerifyIcon'] = this.showVerifyIcon;
    return data;
  }
}