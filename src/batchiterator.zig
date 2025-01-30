const std = @import("std");
const expect = std.testing.expect;
const Data = @import("dataframe.zig").Data;
const DataFrame = @import("dataframe.zig").DataFrame;
const Shape = @import("dataframe.zig").Shape;

pub const BatchIterator = struct {
    index: usize = 0,
    batch_size: usize,
    data: Data = undefined,

    pub fn next(self: *BatchIterator) ?Data {
        if (self.index * self.batch_size >= self.data.values_df.shape.m - 1 or self.data.values_df.data == null or self.index * self.batch_size >= self.data.labels_df.shape.m - 1 or self.data.labels_df.data == null) {
            return null;
        }
        const labels_slice = self.data.labels_df.data.?[(self.index * self.data.labels_df.shape.n)..((self.index + self.batch_size) * self.data.labels_df.shape.n)];
        const data_slice = self.data.values_df.data.?[(self.index * self.data.values_df.shape.n)..((self.index + self.batch_size) * self.data.values_df.shape.n)];
        self.index += 1;
        return Data{
            .labels_df = DataFrame{
                .allocator = self.data.labels_df.allocator,
                .shape = Shape{ .m = self.batch_size, .n = self.data.labels_df.shape.n },
                .data = labels_slice,
            },
            .values_df = DataFrame{
                .allocator = self.data.values_df.allocator,
                .shape = Shape{ .m = self.batch_size, .n = self.data.values_df.shape.n },
                .data = data_slice,
            },
        };
    }
};
