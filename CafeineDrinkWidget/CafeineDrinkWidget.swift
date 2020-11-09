//
//  CafeineDrinkWidget.swift
//  CafeineDrinkWidget
//
//  Created by DouKing on 2020/6/29.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry

	public func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date())
	}

    public func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    public func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
}

extension SimpleEntry {
    public static let previewEntry = SimpleEntry(date: Date())
}

struct CaffeineWidgetData {
    public let drinkName: String
    public let drinkDate: Date
    public let caffeineAmount: Measurement<UnitMass>
    public let phoneName: String?
}

extension CaffeineWidgetData {
    public static let previewData = CaffeineWidgetData(
        drinkName: "Cappuccino",
        drinkDate: Date().advanced(by: -60 * 29 + 5),
        caffeineAmount: Measurement<UnitMass>(value: 56.23, unit: .milligrams),
        phoneName: "coffie"
    )
}

extension Formatter {
    public static let measurement: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 2
        formatter.unitOptions = .providedUnit
        return formatter
    }()
}

struct PlaceholderView : View {
    var body: some View {
        Text("Placeholder View")
    }
}

struct CaffineAmountView: View {
    let data: CaffeineWidgetData

    var body: some View {
        LazyHStack {
            VStack(alignment: .leading) {
                Text("Caffeine")
                    .font(.body)
                    .foregroundColor(Color("espresso"))
                    .bold()

                Text(Formatter.measurement.string(from: data.caffeineAmount))
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("espresso"))
                    .minimumScaleFactor(0.8)
            }

            Spacer(minLength: 0)
        }
        .padding(.all, 8.0)
        .background(ContainerRelativeShape().fill(Color("latte")))
    }
}

struct DrinkView: View {
    let data: CaffeineWidgetData

    var body: some View {
        LazyVStack(alignment: .leading) {
            Text("\(data.drinkName) ☕️")
                .font(.body)
                .bold()
                .foregroundColor(Color("milk"))

            /// NOTE: *New * Date provider API
            Text("\(data.drinkDate, style: .relative) ago")
                .font(.caption)
                .foregroundColor(Color("milk"))
        }
    }
}

struct CafeineDrinkWidgetEntryView : View {
    var entry: Provider.Entry
    var data: CaffeineWidgetData

    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        ZStack {
            Color("cappuccino")
            LazyHStack {
                LazyVStack(alignment: .leading) {
                    CaffineAmountView(data: data)
                    Spacer()
                    DrinkView(data: data)
                }
                .padding(.all, 10)

                if widgetFamily == .systemMedium, let phoneName = data.phoneName {
                    Image(phoneName).resizable()
                }
            }
        }
    }
}

@main
struct CafeineDrinkWidget: Widget {
    private let kind: String = "CafeineDrinkWidget"

	public var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in
			CafeineDrinkWidgetEntryView(entry: entry, data: .previewData)
		}
		.configurationDisplayName("My Widget")
		.description("This is an example widget.")
	}
}

struct CafeineDrinkWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CafeineDrinkWidgetEntryView(entry: .previewEntry, data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            CafeineDrinkWidgetEntryView(entry: .previewEntry, data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.colorScheme, .dark)

            CafeineDrinkWidgetEntryView(entry: .previewEntry, data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemSmall))
                .environment(\.sizeCategory, .extraExtraLarge)

            CafeineDrinkWidgetEntryView(entry: .previewEntry, data: .previewData)
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
