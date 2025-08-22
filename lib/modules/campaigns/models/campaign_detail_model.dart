import '../../../common/models/product_model.dart';

class CampaignDetailModel {
  final int id;
  final List<String> mediaUrls; // Can be images or video thumbnails
  final String vendorName;
  final String vendorAvatarUrl;
  final String vendorDetails;
  final int pledgeCount;
  final int pledgeGoal;
  final int likeCount;
  final int commentCount;
  final String title;
  final DateTime campaignEndDate;
  final double totalFundAmount;
  final String description;
  final List<ProductModel> associatedProducts;

  CampaignDetailModel({
    required this.id,
    required this.mediaUrls,
    required this.vendorName,
    required this.vendorAvatarUrl,
    required this.vendorDetails,
    required this.pledgeCount,
    required this.pledgeGoal,
    required this.likeCount,
    required this.commentCount,
    required this.title,
    required this.campaignEndDate,
    required this.totalFundAmount,
    required this.description,
    required this.associatedProducts,
  });
}
