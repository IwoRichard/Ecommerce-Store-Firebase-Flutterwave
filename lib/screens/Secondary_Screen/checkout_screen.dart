import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/cart_provider.dart';
import '../../widgets/cart_product_card.dart';
import 'package:flutterwave_standard/flutterwave.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.cartData();

    //Calculation of SubTotal, Shipping and Total
    double subTotal = cartProvider.subTotal();
    String SubTotal = subTotal.toStringAsFixed(2);
    double shipping = 10.0;
    double total = subTotal + shipping;
    String Total = total.toStringAsFixed(2);

    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,)
        ),
        elevation: .5,
        title: const Text('CheckOut',style: TextStyle(fontSize: 34,fontWeight: FontWeight.w600,color: Colors.black),),
      ),
      body: cartProvider.getCartList.isEmpty ?
      const Center(child: Text('Cart is Empty'),) :
      Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: cartProvider.getCartList.length,
                  itemBuilder: (context, index) {
                    var data = cartProvider.cartList[index];
                    return CartCard(
                      productId: data.productId, 
                      productImage: data.productImage, 
                      productName: data.productName, 
                      productQuantity: data.productQuantity, 
                      productPrice: data.productPrice,
                    );
                  }
                )
              ),
              amountListTile(SubTotal, 'SubTotal'),
              amountListTile(shipping.toString(), 'Shipping'),
              const Divider(),
              amountListTile(Total, 'Total'),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.2,color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: MaterialButton(
                  color: Colors.black87,
                  disabledColor: Colors.grey.withOpacity(.5),
                  disabledTextColor: Colors.black.withOpacity(.5),
                  onPressed:isLoading ? null : ()async{
                    setState(() {isLoading = true;});
                    handlePayment(Total);
                    clearCart();
                    setState(() {isLoading = false;});
                  },
                  child: const Text(
                    'Purchase',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17,color:Colors.white)
                  ),
                )
              ),
            ],
          )
        ),
    );
  }

  //Checkout amount listTile
  ListTile amountListTile(String amount, String title) {
    return ListTile(
      leading:  Text(title),
      trailing: Text('\$$amount'),
    );
  }

    //Flutterwave payment gateway
    void handlePayment(String amount) async {
      try {
        final Customer customer = Customer(
          name: "Flutterwave Developer",
          phoneNumber: "1234566677777",   
          email: "customer@customer.com" 
        );
        final Flutterwave flutterwave = Flutterwave(
          context: context,
          publicKey: "FLWPUBK_TEST-1c6f5b9bae6b358afdc68e9ac9949939-X",
          currency: "USD",   
          redirectUrl: "https://flutterwave.com/ng/",
          txRef: const Uuid().v1(),   
          amount: amount,   
          customer: customer,   
          paymentOptions: "ussd, card, barter, payattitude",   
          customization: Customization(title: "My Payment"),
          isTestMode: true
        );
        final ChargeResponse response = await flutterwave.charge();
        if (response != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: 
              Text('Purchase Successful'),
              backgroundColor: Colors.green,
              )
            );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: 
              Text(response.toString()),
              backgroundColor: Colors.red,
              )
            );
        }
      } catch (e) {
        print(e);
      }
    }


    //Function to clear cart after successful purchase
    void clearCart()async{
      var snapshots = await FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('userCart')
      .get();

      for(var doc in snapshots.docs){
        await doc.reference.delete();
      }
    }
}