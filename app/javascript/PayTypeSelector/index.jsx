import React from 'react';

import NoPayType from './NoPayType';
import CreditCardPayType from './CreditCardPayType';
import CheckPayType from './CheckPayType';
import PurchaseOrderPayType from './PurchaseOrderPayType';

class PayTypeSelector extends React.Component {
  constructor(props) {
    super(props)
    this.onPayTypeSelected = this.onPayTypeSelected.bind(this);
    this.state = { selectedPayType: null };
  }

  onPayTypeSelected(e) {
    this.setState({ selectedPayType: e.target.value });
  }

  render() {
    let PayTypeCustomComponent;

    switch (this.state.selectedPayType) {
      case 'Credit card':
        PayTypeCustomComponent = CreditCardPayType;
        break;
      case 'Check':
        PayTypeCustomComponent = CheckPayType;
        break;
      case 'Purchase order':
        PayTypeCustomComponent = PurchaseOrderPayType;
        break;
      default:
        PayTypeCustomComponent = NoPayType;
    }

    return (
      <div>
        <div className="field">
          <label htmlFor="order_pay_type">Pay type</label>
          <select onChange={this.onPayTypeSelected} id="pay_type" name="order[pay_type]">
            <option value="">Select a payment method</option>
            <option value="Check">Check</option>
            <option value="Credit card">Credit Card</option>
            <option value="Purchase order">Purchase Order</option>
          </select>
        </div>
        <PayTypeCustomComponent />
      </div>
    );
  }
}

export default PayTypeSelector;
