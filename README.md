# TransportStream

## Transport Stream

### Partial Transport Stream Packet

```swift
PartialTransportStreamPacket(_ bytes: [UInt8])
```

### Transport Stream Packet

```swift
TransportStreamPacket(_ bytes: [UInt8])
```

## Program Specific Information

### Program Map Table

```swift
ProgramMapTable(_ bytes: [UInt8])
```

### Program Association Table

```swift
ProgramAssociationTable(_ bytes: [UInt8])
```

### Conditional Access Table

```swift
Conditional Access Table(_ bytes: [UInt8])
```

### Network Information Table

```swift
NetworkInformationTable(_ bytes: [UInt8])
```

## Others

### CRC

```swift
CyclicRedundancyCheck.check(_ bytes: [UInt8])
```

## Contact

* Devran "Cosmo" Uenal
* Twitter: [@maccosmo](http://twitter.com/maccosmo)
* LinkedIn: [devranuenal](https://www.linkedin.com/in/devranuenal)

## Other Projects

* [BinaryKit](https://github.com/Cosmo/BinaryKit) — BinaryKit helps you to break down binary data into bits and bytes and easily access specific parts.
* [Clippy](https://github.com/Cosmo/Clippy) — Clippy from Microsoft Office is back and runs on macOS! Written in Swift.
* [GrammaticalNumber](https://github.com/Cosmo/GrammaticalNumber) — Turns singular words to the plural and vice-versa in Swift.
* [HackMan](https://github.com/Cosmo/HackMan) — Stop writing boilerplate code yourself. Let hackman do it for you via the command line.
* [ISO8859](https://github.com/Cosmo/ISO8859) — Convert ISO8859 1-16 Encoded Text to String in Swift. Supports iOS, tvOS, watchOS and macOS.
* [SpriteMap](https://github.com/Cosmo/SpriteMap) — SpriteMap helps you to extract sprites out of a sprite map. Written in Swift.
* [StringCase](https://github.com/Cosmo/StringCase) — Converts String to lowerCamelCase, UpperCamelCase and snake_case. Tested and written in Swift.
* [TinyConsole](https://github.com/Cosmo/TinyConsole) — TinyConsole is a micro-console that can help you log and display information inside an iOS application, where having a connection to a development computer is not possible.

## License

TransportStream is released under the [MIT License](http://www.opensource.org/licenses/MIT).
