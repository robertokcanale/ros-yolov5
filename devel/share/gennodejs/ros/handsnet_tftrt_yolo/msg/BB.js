// Auto-generated. Do not edit!

// (in-package handsnet_tftrt_yolo.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class BB {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.obj_class = null;
      this.confidence = null;
      this.coordinates = null;
    }
    else {
      if (initObj.hasOwnProperty('obj_class')) {
        this.obj_class = initObj.obj_class
      }
      else {
        this.obj_class = '';
      }
      if (initObj.hasOwnProperty('confidence')) {
        this.confidence = initObj.confidence
      }
      else {
        this.confidence = 0.0;
      }
      if (initObj.hasOwnProperty('coordinates')) {
        this.coordinates = initObj.coordinates
      }
      else {
        this.coordinates = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BB
    // Serialize message field [obj_class]
    bufferOffset = _serializer.string(obj.obj_class, buffer, bufferOffset);
    // Serialize message field [confidence]
    bufferOffset = _serializer.float32(obj.confidence, buffer, bufferOffset);
    // Serialize message field [coordinates]
    bufferOffset = _arraySerializer.float32(obj.coordinates, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BB
    let len;
    let data = new BB(null);
    // Deserialize message field [obj_class]
    data.obj_class = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [confidence]
    data.confidence = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [coordinates]
    data.coordinates = _arrayDeserializer.float32(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.obj_class);
    length += 4 * object.coordinates.length;
    return length + 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'handsnet_tftrt_yolo/BB';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'dfc87673751af1dddbaefa01947e8324';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    const resolved = new BB(null);
    if (msg.obj_class !== undefined) {
      resolved.obj_class = msg.obj_class;
    }
    else {
      resolved.obj_class = ''
    }

    if (msg.confidence !== undefined) {
      resolved.confidence = msg.confidence;
    }
    else {
      resolved.confidence = 0.0
    }

    if (msg.coordinates !== undefined) {
      resolved.coordinates = msg.coordinates;
    }
    else {
      resolved.coordinates = []
    }

    return resolved;
    }
};

module.exports = BB;
