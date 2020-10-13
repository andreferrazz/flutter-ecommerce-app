const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

const firestore = admin.firestore();
const settings = { timestampInSnapshots: true };
firestore.settings(settings)
const stripe = require('stripe')('sk_test_51HZ5IyDuWchk5LI5gaAKnX7nAmUR2XgAZUaUaHDDCCEnWYeTKGhaDYki6eRbZkZQQgED2WOqWggU6DsxVfO69ccw00gZhwwAp3');
exports.createPaymentIntent = functions.https.onCall((data, context) => {
    return stripe.paymentIntents.create({
      amount: data.amount,
      currency: data.currency,
      payment_method_types: ['card'],
  });
});
