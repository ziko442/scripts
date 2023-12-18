import csv

def replace_white_with_red(input_csv, output_csv):
    with open(input_csv, 'r', newline='') as infile, open(output_csv, 'w', newline='') as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile)

        for row in reader:
            # Replace "White" with "Red" in each cell of the row
            updated_row = [cell.replace("White", "Red") for cell in row]
            writer.writerow(updated_row)

# Example usage:
replace_white_with_red('input.csv', 'output.csv')
