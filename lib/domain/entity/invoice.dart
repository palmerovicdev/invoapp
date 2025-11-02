class Invoice {
  final int id;
  final int companyId;
  final String number;
  final String? reference;
  final String? currency;
  final DateTime issuedAt;
  final DateTime dueAt;
  final InvoiceState state;
  final Money taxAmount;
  final Money amountWithoutTaxes;
  final Money amount;
  final Money amountDue;
  final Money amountPaid;
  final String humanizedAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? sendAt;
  final String? description;
  final Contact contact;

  Invoice({
    required this.id,
    required this.companyId,
    required this.number,
    this.reference,
    this.currency,
    required this.issuedAt,
    required this.dueAt,
    required this.state,
    required this.taxAmount,
    required this.amountWithoutTaxes,
    required this.amount,
    required this.amountDue,
    required this.amountPaid,
    required this.humanizedAmount,
    required this.createdAt,
    required this.updatedAt,
    this.sendAt,
    this.description,
    required this.contact,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as int,
      companyId: json['company_id'] as int,
      number: json['number'] as String,
      reference: json['reference'] as String?,
      currency: json['currency'] as String?,
      issuedAt: DateTime.parse(json['issued_at'] as String),
      dueAt: DateTime.parse(json['due_at'] as String),
      state: InvoiceState.fromString(json['state'] as String),
      taxAmount: Money.fromJson(json['tax_amount'] as Map<String, dynamic>),
      amountWithoutTaxes: Money.fromJson(
        json['amount_without_taxes'] as Map<String, dynamic>,
      ),
      amount: Money.fromJson(json['amount'] as Map<String, dynamic>),
      amountDue: Money.fromJson(json['amount_due'] as Map<String, dynamic>),
      amountPaid: Money.fromJson(json['amount_paid'] as Map<String, dynamic>),
      humanizedAmount: json['humanized_amount'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      sendAt: json['send_at'] != null ? DateTime.parse(json['send_at'] as String) : null,
      description: json['description'] as String?,
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>),
    );
  }
}

class Money {
  final int cents;
  final String currency;
  final String formatted;

  Money({
    required this.cents,
    required this.currency,
    required this.formatted,
  });

  factory Money.fromJson(Map<String, dynamic> json) {
    return Money(
      cents: json['cents'] as int,
      currency: json['currency'] as String,
      formatted: json['formatted'] as String,
    );
  }
}

class Contact {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;
  final bool actsAsCostumer;
  final bool actsAsSupplier;
  final String companyNumber;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? logo;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
    required this.actsAsCostumer,
    required this.actsAsSupplier,
    required this.companyNumber,
    required this.createdAt,
    required this.updatedAt,
    this.logo,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      actsAsCostumer: json['acts_as_costumer'] as bool,
      actsAsSupplier: json['acts_as_supplier'] as bool,
      companyNumber: json['company_number'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      logo: json['logo'],
    );
  }
}

enum InvoiceState {
  draft,
  awaitingPayment,
  paid,
  overdue,
  cancelled;

  static InvoiceState fromString(String value) {
    switch (value) {
      case 'draft':
        return InvoiceState.draft;
      case 'awaiting_payment':
        return InvoiceState.awaitingPayment;
      case 'paid':
        return InvoiceState.paid;
      case 'overdue':
        return InvoiceState.overdue;
      case 'cancelled':
        return InvoiceState.cancelled;
      default:
        return InvoiceState.draft;
    }
  }
}
