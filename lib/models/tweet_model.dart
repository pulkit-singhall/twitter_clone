import 'package:flutter/cupertino.dart';

@immutable
class TweetModel {
  final String text;
  final List<String> hashtags;
  final List<String> links;
  final String userId;
  final String tweetId;
  final DateTime tweetTime;
  final List<String> likes;
  final List<String> comments;
  final int reshareCount;

  const TweetModel(
      {required this.likes,
      required this.comments,
      required this.hashtags,
      required this.links,
      required this.userId,
      required this.tweetId,
      required this.tweetTime,
      required this.text,
      required this.reshareCount});

  TweetModel copyWith({
    String? text,
    List<String>? hashtags,
    List<String>? links,
    String? userId,
    DateTime? tweetTime,
    List<String>? likes,
    List<String>? comments,
    String? tweetId,
    int? reshareCount,
  }) {
    return TweetModel(
      text: text ?? this.text,
      hashtags: hashtags ?? this.hashtags,
      links: links ?? this.links,
      userId: userId ?? this.userId,
      tweetTime: tweetTime ?? this.tweetTime,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      tweetId: tweetId ?? this.tweetId,
      reshareCount: reshareCount ?? this.reshareCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'text': text});
    result.addAll({'hashtags': hashtags});
    result.addAll({'links': links});
    result.addAll({'userId': userId});
    result.addAll({'tweetTime': tweetTime.millisecondsSinceEpoch});
    result.addAll({'likes': likes});
    result.addAll({'comments': comments});
    result.addAll({'reshareCount': reshareCount});

    return result;
  }

  factory TweetModel.fromMap(Map<String, dynamic> map) {
    return TweetModel(
      text: map['text'] ?? '',
      hashtags: List<String>.from(map['hashtags']),
      links: List<String>.from(map['links']),
      userId: map['userId'] ?? '',
      tweetTime: DateTime.fromMillisecondsSinceEpoch(map['tweetTime']),
      likes: List<String>.from(map['likes']),
      comments: List<String>.from(map['comments']),
      tweetId: map['\$id'] ?? '',
      reshareCount: map['reshareCount']?.toInt() ?? 0,
    );
  }

  @override
  String toString() {
    return 'Tweet(text: $text, hashtags: $hashtags, links: $links, userId: $userId, tweetTime: $tweetTime, likes: $likes, comments: $comments, tweetId: $tweetId, reshareCount: $reshareCount)';
  }
}
