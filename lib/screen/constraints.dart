import 'package:flutter/material.dart';

const MESSAGE_COLLECTION = "message";
const MESSAGE_TEXT = "msgText";
const MESSAGE_SENDER = "sender";

const kReceiverMessageBubble = BorderRadius.only(
    topRight: Radius.circular(18),
    bottomLeft: Radius.circular(18),
    bottomRight: Radius.circular(18));

const kSenderMessageBubble = BorderRadius.only(
    topLeft: Radius.circular(18),
    bottomLeft: Radius.circular(18),
    bottomRight: Radius.circular(18));
