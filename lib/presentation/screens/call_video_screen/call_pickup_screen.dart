import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone_clean_arch/common/utils/app_const.dart';
import 'package:whats_app_clone_clean_arch/presentation/bloc/communication/communication_cubit.dart';
import '../../../data/model/call.dart';
import 'call_screen.dart';


class CallPickupScreen extends StatelessWidget {
  final Widget scaffold;
  const CallPickupScreen({Key? key, required this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:BlocProvider.of<CommunicationCubit>(context).callStream ,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.data() != null) {
          Call call =
              Call.fromMap(snapshot.data!.data() as Map<String, dynamic>);
          if (!call.hasDialled) {
            return Scaffold(
              body: Container(
                alignment: Alignment.center,
                padding:  EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      AppConst.incomingCall,
                      style: TextStyle(
                        fontSize: 32.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 48.h),
                    CircleAvatar(
                      backgroundImage: NetworkImage(call.callerPic),
                      radius: 60,
                    ),
                    SizedBox(height: 48.h),
                    Text(
                      call.callerName,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                     SizedBox(height: 80.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.call_end,
                              color: Colors.redAccent),
                        ),
                         SizedBox(width: 24.w),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CallScreen(
                                  channelId: call.callId,
                                  call: call,
                                  isGroupChat: false,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return scaffold;
      },
    );
  }
}
