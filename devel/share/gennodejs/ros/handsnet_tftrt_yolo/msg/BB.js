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
      this.class = null;
      this.confidence = null;
      this.coordinates = null;
    }
    else {
      if (initObj.hasOwnProperty('class')) {
        this.class = initObj.class
      }
      else {
        this.class = '';
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
        this.coordinates = new Array(4).fill(0);
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type BB
    // Serialize message field [class]
    bufferOffset = _serializer.string(obj.class, buffer, bufferOffset);
    // Serialize message field [confidence]
    bufferOffset = _serializer.float32(obj.confidence, buffer, bufferOffset);
    // Check that the constant length array field [coordinates] has the right length
    if (obj.coordinates.length !== 4) {
      throw new Error('Unable to serialize array field coordinates - length must be 4')
    }
    // Serialize message field [coordinates]
    bufferOffset = _arraySerializer.float32(obj.coordinates, buffer, bufferOffset, 4);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type BB
    let len;
    let data = new BB(null);
    // Deserialize message field [class]
    data.class = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [confidence]
    data.confidence = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [coordinates]
    data.coordinates = _arrayDeserializer.float32(buffer, bufferOffset, 4)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.class);
    return length + 24;
  }

  static datatype() {
    // Returns string type for a message object
    return 'handsnet_tftrt_yolo/BB';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e5df805725a7fa5ef20dff2b5693f3d6';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string class
    float32 confidence
    float32[4] coordinates
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new BB(null);
    if (msg.class !== undefined) {
      resolved.class = msg.class;
    }
    else {
      resolved.class = ''
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
      resolved.coordinates = new Array(4).fill(0)
    }

    return resolved;
    }
};

module.exports = BB;
