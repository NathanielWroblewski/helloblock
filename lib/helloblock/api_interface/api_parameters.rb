module HelloBlock
  module APIParameters
    API_PARAMETERS = {
      address:     :addresses,
      transaction: :txHashes,
      propagate:   :rawTxHex,
      to:          :toAddress
    }
  end
end
