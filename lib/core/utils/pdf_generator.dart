import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../app/modules/predictor/models/predictor_data_model.dart';

class PdfReportGenerator {
  static Future<void> generateAndDownloadReport(
    PredictorInputData data,
    int predictedAIR,
    double percentile,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header Brand Banner
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#5A2CEE'),
                  borderRadius: pw.BorderRadius.circular(12),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'CareerMarg Education Consultancy',
                          style: pw.TextStyle(
                            color: PdfColors.white,
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'ISO 9001:2015 Certified • Official NEET Prediction Report',
                          style: const pw.TextStyle(color: PdfColors.white, fontSize: 9),
                        ),
                      ],
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromHex('#E2B659'),
                        borderRadius: pw.BorderRadius.circular(6),
                      ),
                      child: pw.Text(
                        'VERIFIED REPORT',
                        style: pw.TextStyle(
                          color: PdfColor.fromHex('#100E2E'),
                          fontSize: 9,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Candidate Information Matrix
              pw.Container(
                padding: const pw.EdgeInsets.all(14),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#F8FAFC'),
                  borderRadius: pw.BorderRadius.circular(10),
                  border: pw.Border.all(color: PdfColor.fromHex('#E2E8F0')),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPdfMetaItem('Candidate Name', data.fullName),
                    _buildPdfMetaItem('Phone No.', '+91 ${data.mobileNo}'),
                    _buildPdfMetaItem('Home State', data.state),
                    _buildPdfMetaItem('Target Year', data.year),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),

              // Score Matrix Row
              pw.Row(
                children: [
                  _buildPdfScoreBox('NEET SCORE', '${data.score} / 720', PdfColor.fromHex('#5A2CEE')),
                  pw.SizedBox(width: 10),
                  _buildPdfScoreBox('PREDICTED AIR', '#$predictedAIR', PdfColor.fromHex('#10B981')),
                  pw.SizedBox(width: 10),
                  _buildPdfScoreBox('PERCENTILE', '${percentile.toStringAsFixed(2)}%', PdfColor.fromHex('#F59E0B')),
                ],
              ),
              pw.SizedBox(height: 24),

              // Qualified Colleges Section
              pw.Text(
                'Comprehensive Eligible Colleges & Quota Matrix',
                style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),

              _buildPdfCollegeItem('Patna Medical College (PMCH)', 'Patna, Bihar', 'State Quota (85%)', '₹1.2L / yr', 'Closing AIR: 4,520'),
              _buildPdfCollegeItem('Dhaka National Medical College', 'Dhaka, Bangladesh', 'NMC Direct MBBS', '₹32L Package', 'Direct Allotment'),
              _buildPdfCollegeItem('Kazakh National Medical University', 'Almaty, Kazakhstan', 'MCI / WHO Approved', '₹18.5L Course', 'NEET Qualified'),
              _buildPdfCollegeItem('Kasturba Medical College (KMC)', 'Manipal, Karnataka', 'Deemed Management', '₹17.8L / yr', 'Closing AIR: 42,100'),
              _buildPdfCollegeItem('JLN Medical College', 'Bhagalpur, Bihar', 'State Quota (85%)', '₹95K / yr', 'Closing AIR: 12,400'),

              pw.Spacer(),

              // Footer Note
              pw.Divider(color: PdfColor.fromHex('#E2E8F0')),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Report Generated on careermarg.com', style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 9)),
                  pw.Text('Helpline: +91 8448443305', style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 9)),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'CareerMarg_${data.fullName}_Report.pdf',
    );
  }

  static pw.Widget _buildPdfMetaItem(String title, String val) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 8)),
        pw.SizedBox(height: 2),
        pw.Text(val, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
      ],
    );
  }

  static pw.Widget _buildPdfScoreBox(String label, String value, PdfColor color) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: pw.BoxDecoration(
          color: PdfColor.fromHex('#FFFFFF'),
          borderRadius: pw.BorderRadius.circular(8),
          border: pw.Border.all(color: color, width: 1.2),
        ),
        child: pw.Column(
          children: [
            pw.Text(label, style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 8)),
            pw.SizedBox(height: 4),
            pw.Text(value, style: pw.TextStyle(color: color, fontWeight: pw.FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildPdfCollegeItem(String name, String loc, String quota, String fee, String cutoff) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 8),
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#F8FAFC'),
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(color: PdfColor.fromHex('#E2E8F0')),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(name, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
              pw.Text('$loc • $quota', style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 8)),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(fee, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9, color: PdfColor.fromHex('#5A2CEE'))),
              pw.Text(cutoff, style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 8)),
            ],
          ),
        ],
      ),
    );
  }
}