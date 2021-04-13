// Auto-generated. Do not edit!

// (in-package handsnet_yolo.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let BB = require('./BB.js');

//-----------------------------------------------------------

class Image_BB {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.bb_number = null;
      this.bb_array = null;
    }
    else {
      if (initObj.hasOwnProperty('bb_number')) {
        this.bb_number = initObj.bb_number
      }
      else {
        this.bb_number = 0;
      }
      if (initObj.hasOwnProperty('bb_array')) {
        this.bb_array = initObj.bb_array
      }
      else {
        this.bb_array = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Image_BB
    // Serialize message field [bb_number]
    bufferOffset = _serializer.int16(obj.bb_number, buffer, bufferOffset);
    // Serialize message field [bb_array]
    // Serialize the length for message field [bb_array]
    bufferOffset = _serializer.uint32(obj.bb_array.length, buffer, bufferOffset);
    obj.bb_array.forEach((val) => {
      bufferOffset = BB.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Image_BB
    let len;
    let data = new Image_BB(null);
    // Deserialize message field [bb_number]
    data.bb_number = _deserializer.int16(buffer, bufferOffset);
    // Deserialize message field [bb_array]
    // Deserialize array length for message field [bb_array]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.bb_array = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.bb_array[i] = BB.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.bb_array.forEach((val) => {
      length += BB.getMessageSize(val);
    });
    return length + 6;
  }

  static datatype() {
    // Returns string type for a message object
    return 'handsnet_yolo/Image_BB';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e36224c45647457f9e206d30e8546220';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int16 bb_number
    handsnet_yolo/BB[] bb_array
    ================================================================================
    MSG: handsnet_yolo/BB
    string obj_class
    float32 confidence
    float32[] coordinates
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Image_BB(null);
    if (msg.bb_number !== undefined) {
      resolved.bb_number = msg.bb_number;
    }
    else {
      resolved.bb_number = 0
    }

    if (msg.bb_array !== undefined) {
      resolved.bb_array = new Array(msg.bb_array.length);
      for (let i = 0; i < resolved.bb_array.length; ++i) {
        resolved.bb_array[i] = BB.Resolve(msg.bb_array[i]);
      }
    }
    else {
      resolved.bb_array = []
    }

    return resolved;
    }
};

module.exports = Image_BB;
