// Generated by gencpp from file handsnet_yolo/BB.msg
// DO NOT EDIT!


#ifndef HANDSNET_YOLO_MESSAGE_BB_H
#define HANDSNET_YOLO_MESSAGE_BB_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace handsnet_yolo
{
template <class ContainerAllocator>
struct BB_
{
  typedef BB_<ContainerAllocator> Type;

  BB_()
    : class()
    , confidence(0.0)
    , coordinates()  {
      coordinates.assign(0.0);
  }
  BB_(const ContainerAllocator& _alloc)
    : class(_alloc)
    , confidence(0.0)
    , coordinates()  {
  (void)_alloc;
      coordinates.assign(0.0);
  }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _class_type;
  _class_type class;

   typedef float _confidence_type;
  _confidence_type confidence;

   typedef boost::array<float, 4>  _coordinates_type;
  _coordinates_type coordinates;





  typedef boost::shared_ptr< ::handsnet_yolo::BB_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::handsnet_yolo::BB_<ContainerAllocator> const> ConstPtr;

}; // struct BB_

typedef ::handsnet_yolo::BB_<std::allocator<void> > BB;

typedef boost::shared_ptr< ::handsnet_yolo::BB > BBPtr;
typedef boost::shared_ptr< ::handsnet_yolo::BB const> BBConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::handsnet_yolo::BB_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::handsnet_yolo::BB_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::handsnet_yolo::BB_<ContainerAllocator1> & lhs, const ::handsnet_yolo::BB_<ContainerAllocator2> & rhs)
{
  return lhs.class == rhs.class &&
    lhs.confidence == rhs.confidence &&
    lhs.coordinates == rhs.coordinates;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::handsnet_yolo::BB_<ContainerAllocator1> & lhs, const ::handsnet_yolo::BB_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace handsnet_yolo

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::handsnet_yolo::BB_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::handsnet_yolo::BB_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::handsnet_yolo::BB_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::handsnet_yolo::BB_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::handsnet_yolo::BB_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::handsnet_yolo::BB_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::handsnet_yolo::BB_<ContainerAllocator> >
{
  static const char* value()
  {
    return "e5df805725a7fa5ef20dff2b5693f3d6";
  }

  static const char* value(const ::handsnet_yolo::BB_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xe5df805725a7fa5eULL;
  static const uint64_t static_value2 = 0xf20dff2b5693f3d6ULL;
};

template<class ContainerAllocator>
struct DataType< ::handsnet_yolo::BB_<ContainerAllocator> >
{
  static const char* value()
  {
    return "handsnet_yolo/BB";
  }

  static const char* value(const ::handsnet_yolo::BB_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::handsnet_yolo::BB_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string class\n"
"float32 confidence\n"
"float32[4] coordinates\n"
;
  }

  static const char* value(const ::handsnet_yolo::BB_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::handsnet_yolo::BB_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.class);
      stream.next(m.confidence);
      stream.next(m.coordinates);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct BB_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::handsnet_yolo::BB_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::handsnet_yolo::BB_<ContainerAllocator>& v)
  {
    s << indent << "class: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.class);
    s << indent << "confidence: ";
    Printer<float>::stream(s, indent + "  ", v.confidence);
    s << indent << "coordinates[]" << std::endl;
    for (size_t i = 0; i < v.coordinates.size(); ++i)
    {
      s << indent << "  coordinates[" << i << "]: ";
      Printer<float>::stream(s, indent + "  ", v.coordinates[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // HANDSNET_YOLO_MESSAGE_BB_H
